mkpos = (tx, ty, tz, rx, ry, rz) ->
  { tx: tx, ty: ty, tz: tz, rx: rx, ry: ry, rz: rz }
  
transf = (elem, pos) ->
  transform = ""
  transform += "translate3d(#{pos.tx}px, #{pos.ty}px, #{pos.tz}px)"
  transform += "rotateX(#{pos.rx}deg) rotateY(#{pos.ry}deg) rotateZ(#{pos.rz}deg)"
  elem.style.webkitTransform = transform

g = window

$("body").bind "sass_loadeds", =>
  # g.fivetastic.dev_mode() # comment this in production
  $("body").unbind "page_loaded"
  
  height = $(window).height() - $("header").height()
  
  videos = _($("#rvideos video")).map (el) -> el
  
  _(videos).each (vid) ->
    vid.play()
    $(vid).on "loadeddata", ->
      vid.muted =  true
  
  $("#rvideos").height height #TODO: calculate from browser height
  rvideos = $("#rvideos")
  # height = $("#rvideos").height()

  
  cur_evt = null
  
  y = 80
  total_w = $(window).width()
  width = total_w * 0.6
  w2 = (width - 585) / 5
  
  
  pos_front = null
  pos_next  = null
  pos_prev  = null
  pos_back  = null
  pos_back2  = null
  
  update_pos = ->
    total_w = $(window).width()
    width = total_w * 0.6
    wid = total_w/2-width/1.6
  
    factor = 1.12
    
    pos_front = mkpos wid, y, 0, 0, 0, 0
    pos_next = mkpos wid+width*factor,   y, -width/2, 0, 45, 0
    pos_prev = mkpos wid-width*factor, y, -width/2, 0, -45, 0
    pos_back = mkpos wid, y, -width*2, 0, 180, 0
    pos_back2 = mkpos wid, y, -width*2, 0, -180, 0
  
  anim =  ->
    update_pos()
    
    transf videos[0], pos_front
    transf videos[1], pos_next
    transf videos[2], pos_back
    transf videos[3], pos_back2
    transf videos[4], pos_prev
  

    
  $("#rvideos").on "click", ->  
    update_pos()
    videos[5] = videos[0]
    videos.shift()
    transf videos[0], pos_front
    transf videos[1], pos_next
    transf videos[2], pos_back
    transf videos[3], pos_back2
    transf videos[4], pos_prev
      
  anim()
  
  $(window).on "resize", anim

      
    
  utils = {
    random_choose: (array) ->
      rand_order = ->
        Math.round(Math.random()) - 0.5
      array.sort rand_order
      array[0]
  }
