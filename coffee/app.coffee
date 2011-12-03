unless window.requestAnimationFrame
  window.requestAnimationFrame = (->
    window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or window.oRequestAnimationFrame or window.msRequestAnimationFrame or (callback, element) ->
      window.setTimeout callback, 1000 / 60
  )()

transf = (elem, tx, ty, tz, rx, ry, rz) ->
  transform = ""
  transform += "translate3d(#{tx}px, #{ty}px, #{tz}px)"
  transform += "rotateX(#{rx}deg) rotateY(#{ry}deg) rotateZ(#{rz}deg)"
  elem.style.webkitTransform = transform

g = window

$("body").bind "sass_loadeds", =>
  # g.fivetastic.dev_mode() # comment this in production
  $("body").unbind "page_loaded"
  
  console.log "app coffee loaded"
  
  height = $(window).height() - $("header").height()
  
  vid = document.getElementById("video")
  vid.play()
  
  $("#rvideos").height height #TODO: calculate from browser height
  rvideos = $("#rvideos")
  video = $("#rvideos video:first")
  vid = document.getElementById("video")
  width = $("#rvideos").width()
  # height = $("#rvideos").height()
  center = { 
    x: width/2, 
    y: height/2  
  }
  
  cur_evt = null
  
  vid_next = document.getElementById("video_next")
  vid_next2 = document.getElementById("video_next2")
  vid_prev = document.getElementById("video_prev")
  
  y = 80
  width = $(window).width() * 0.6
  w2 = (width - 585) / 5
  
  anim =  ->
  
    
    transf vid, 0, y, -100, 0, 1, 0
    
    transf vid_next, width/2+w2, y, -400, 0, 90, 0
    
    
    transf vid_next2, width/2+w2+100, y, -600, 0, 0, 0
    transf vid_prev, -width+300, y, 200, 0, 90, 0 
  
  
  video.on "loadeddata", ->
    vid.muted =  true
    # $("#rvideos").on "mousemove", (evt) -> 
      # cur_evt = evt
      # # _.defer -> 
      # anim(evt)
    $("#video").on "click", ->  
      transf vid_prev, -width*2, y, 200, 0, 90, 0
      $(vid_prev).on "webkitTransitionEnd", ->
        transf vid, -width+300, y, 200, 0, 90, 0
        $(vid).on "webkitTransitionEnd", ->
          transf vid_next, 0, 80, -100, 0, 1, 0
          $(vid_next).on "webkitTransitionEnd", ->
            transf vid_next2, width/2+w2, y, -400, 0, 90, 0
      
      
    # evt = { offsetX: center.x, offsetY: center.y  }
    anim()
    
    $(window).on "resize", anim
      
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
