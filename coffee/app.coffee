mkpos = (tx, ty, tz, rx, ry, rz) ->
  { tx: tx, ty: ty, tz: tz, rx: rx, ry: ry, rz: rz }
  
transf = (elem, pos) ->
  transform = ""
  transform += "translate3d(#{pos.tx}px, #{pos.ty}px, #{pos.tz}px)"
  transform += "rotateX(#{pos.rx}deg) rotateY(#{pos.ry}deg) rotateZ(#{pos.rz}deg)"
  elem.style.webkitTransform = transform

  
resize = ->
  height = $(window).height() - $("header").height()
  $("#rvideos").height height #TODO: calculate from browser height

play_video = (video, opt) -> 
  video.play()
  $(video).on "loadeddata", ->
    video.muted =  true if opt == "muted"


g = window

$("body").bind "sass_loadeds", =>
  # g.fivetastic.dev_mode() # comment this in production
  $("body").unbind "page_loaded"
  
  
  
  videos = _($("#rvideos video, #rvideos img")).map (el) -> el
  

  
  _(videos).each (vid, idx) ->
    if idx <= 0
      play_video(vid, "muted")
        
  resize()
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
  
  front_video = ->
    videos[0]
  
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
    
    if navigator.userAgent.match(/Chrome/)
      pos_back2 =  mkpos -width*4, -600, 0, 0, 0, 0
      pos_back =  mkpos width*4, -600, 0, 0, 0, 0 
    
  
  transf_all = ->
    transf videos[0], pos_front
    transf videos[1], pos_next
    transf videos[2], pos_back
    transf videos[3], pos_back2
    transf videos[4], pos_prev
    
    
  anim =  ->
    update_pos()
    transf_all()
    resize()

  
  switch_to_video = (elem, pos=pos_front) ->
    $(elem).css("zIndex", 20)
    video_src = $(elem).data("video")
    uid = Math.round(Math.random() * 10000000)
    video = $("<video id='#{uid}'><source src='#{video_src}'></source></video>")
    $("#rvideos").append(video)
    # video.css("opacity", 0)
    vid = $("##{uid}")[0]
    transf vid, pos_next
    setTimeout ->
      transf vid, pos_front
    , 10
    vid

    # video.css("opacity", 1)

  switch_to_img = (elem) ->

  activate = (vid) ->
    front = $(front_video())
    play_video vid, "muted"
    videos[0] = vid
    _(videos).each (vid, idx) ->
      tag = vid.nodeName.toLowerCase()
      if tag == "video"
        vid.pause()
    $(videos[0]).on "loadeddata", ->
      front.remove()
    videos[0].play()

  next = ->  
    $("#rvideos").off "click"
    update_pos()
    videos[5] = front_video()
    videos.shift()    
    transf_all()
    
    vid = switch_to_video front_video()
    
    $("video:first").on "webkitTransitionEnd", (evt) ->
      $("video:first").off "webkitTransitionEnd"
      bind_click()
      activate vid
      # anim()
      
  bind_click = ->
    $("#rvideos").on "click", ->  
       next()
  
  bind_click()
  anim()
  
  $(window).on "resize", anim

      
    
  utils = {
    random_choose: (array) ->
      rand_order = ->
        Math.round(Math.random()) - 0.5
      array.sort rand_order
      array[0]
  }
