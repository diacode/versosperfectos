require 'rake'
require 'open3'

include Rails.application.routes.url_helpers

namespace :backuper do
  task :start => :environment do
    env = Rails.env
    log = TaskLog.new purpose: 'backup'

    # Database settings
    db_username = ActiveRecord::Base.connection_config[:username]
    db_password = ActiveRecord::Base.connection_config[:password]
    db_name = ActiveRecord::Base.connection_config[:database]
    
    # Hipchat API client initialize
    slack = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL'], username: 'Backup'

    # Commands to be executed
    commands = [
      # Dump and zip database
      "mysqldump --user=#{db_username} --password=#{db_password} #{db_name} | gzip > /home/deploy/backup/vp.sql.gz",
      # Push database
      "rsync -avz /home/deploy/backup/vp.sql.gz #{ENV['BACKUP_USERNAME']}@#{ENV['BACKUP_HOST']}:#{ENV['BACKUP_PATH']}/db",
      # Asset syncing
      "rsync -avz /home/rails/versosperfectos.com/shared/public/system #{ENV['BACKUP_USERNAME']}@#{ENV['BACKUP_HOST']}:#{ENV['BACKUP_PATH']}/files",
      "rsync -avz /home/rails/versosperfectos.com/shared/public/uploads #{ENV['BACKUP_USERNAME']}@#{ENV['BACKUP_HOST']}:#{ENV['BACKUP_PATH']}/files"
    ]

    t1 = Time.now

    commands.each do |cmd|
      Open3.popen3(cmd) do |stdin, stdout, stderr|
        log.stdout << "#{cmd}\n"
        log.stdout << stdout.readlines.join
        log.stderr << stderr.readlines.join
        stdout.close
        stderr.close
      end
    end

    log.save
    log_link = "<a href=\"#{admin_task_log_url(log)}\">Ver detalle</a>"
    t2 = Time.now

    if log.successful?
      slack.ping "Copia de seguridad realizada en #{(t2-t1).round} segundos (#{log_link})"
    else
      slack.ping "Copia de seguridad <strong>fallida</strong> (#{log_link})"
      BackuperMailer.backup_failed(log).deliver
    end
  end
end