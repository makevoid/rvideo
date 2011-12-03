unless window.requestAnimationFrame
  window.requestAnimationFrame = (->
    window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or window.oRequestAnimationFrame or window.msRequestAnimationFrame or (callback, element) ->
      window.setTimeout callback, 1000 / 60
  )()


g = window
<<<<<<< HEAD
$("body").bind "sass_loadeds", =>
  # g.fivetastic.dev_mode() # comment this in production
  $("body").unbind "page_loaded"
  
  console.log "app coffee loaded"
  
  
  vid = document.getElementById("video")
  vid.play()
  
  
  anim = (evt) ->
    console.log evt.clientX, evt.clientY
    $(this).css("-moz-transform","rotateY(20deg) rotateX(20deg) rotateZ(5deg)")
    $(this).css "-webkit-transform", "rotate3d(1, 3, 0.5, 50deg)"
  
  
  $("video").on "loadeddata", ->
    vid.muted =  true
    $("video").on "mousemove", (evt) -> 
      anim evt  
      
  # rotate = ->
  #   $("video").css "-webkit-transform", "rotate3d(6, 2, 0.5, 90deg)"
  #   
  # back = ->
  #   $("video").css "-webkit-transform", "rotate3d(1, 3, 0.5, 50deg)"
  # 
  # $("video").hover rotate, back
      
    
  utils = {
    random_choose: (array) ->
      rand_order = ->
        Math.round(Math.random()) - 0.5
      array.sort rand_order
      array[0]
  }
=======
$("body").bind "sass_loadeds", ->
  g.fivetastic.dev_mode() # comment this in production
  $("body").unbind "page_loaded"
  

# require_api = (api) ->
#   $.get "/fivetastic/api/lastfm.coffee", (coffee) ->
#     eval CoffeeScript.compile(coffee)
#     
# # APIS: fb, lastfm, delicious, twitter
# require_api "lastfm"



console.log "app coffee loaded"
>>>>>>> 7c3a0f60b992c52f92577efff5d9d65873144901
