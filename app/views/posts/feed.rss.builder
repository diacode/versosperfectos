xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "VersosPerfectos.com | Noticias"
    xml.description "Información sobre Hip-Hop español e internacional. La base de datos más completa sobre rap español"
    xml.link feed_posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.author post.creator_effective_name
        xml.link post_extended_url(post.permalink_hash)
        xml.guid post_extended_url(post.permalink_hash)
      end
    end
  end
end