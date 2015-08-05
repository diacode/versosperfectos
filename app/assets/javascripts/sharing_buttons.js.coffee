# Facebook
((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  return  if d.getElementById(id)
  js = d.createElement(s)
  js.id = id
  js.src = "//connect.facebook.net/es_ES/all.js#xfbml=1&appId=400526916627674"
  fjs.parentNode.insertBefore js, fjs
) document, "script", "facebook-jssdk"

# Twitter
not ((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  p = (if /^http:/.test(d.location) then "http" else "https")
  unless d.getElementById(id)
    js = d.createElement(s)
    js.id = id
    js.src = p + "://platform.twitter.com/widgets.js"
    fjs.parentNode.insertBefore js, fjs
) document, "script", "twitter-wjs"