class BackuperMailer < ActionMailer::Base
  default from: "contacto@versosperfectos.com"

  def backup_failed(task_log)
    @task_log = task_log
    mail(to: 'hopsor@gmail.com', subject: 'VersosPerfectos: Error en el backup')
  end
end
