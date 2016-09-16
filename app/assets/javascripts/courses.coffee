
'use strict'
$(document).ready ->

  tinyMCE.init
    selector: 'textarea.tinymce'
    language: "es"
  $(document).on "fields_added.nested_form_fields", (event, param) ->
    contador=undefined
    paneles=undefined
    i=0
    contador=($('.tinymce').size())-1

    #$('#course_programations_attributes_'+contador+'_plan').tinymce
    #  theme: 'modern'

    paneles=document.querySelectorAll('.panel-title.panel-curso')
    otros=document.querySelectorAll('.panel-collapse.panel-curso')
    for value, index in paneles
      value.dataset.target='#panel-'+index
    for value, index in otros
      value.id="panel-"+index
    $(".check-switch").bootstrapSwitch()

  


  contador=undefined
  paneles=undefined
  i=0
  contador=($('.tinymce').size())-1


  paneles=document.querySelectorAll('.panel-title.panel-curso')
  otros=document.querySelectorAll('.panel-collapse.panel-curso')
  for value, index in paneles
    value.dataset.target='#panel-'+index
  for value, index in otros
    value.id="panel-"+index
  $(".check-switch").bootstrapSwitch()





  $(".check-switch").bootstrapSwitch
    OnText: 'Activo'
  #Evento al presionar tecla 
  $('#filtro_cursos').keyup (e) ->
    clearTimeout $.data(this, 'timer')
    if e.keyCode == 13
      searchCur true
    else
      $(this).data 'timer', setTimeout(searchCur, 500)
    return
  #Busca coincidencias de cusos

  searchCur = (force) ->
    cadena = undefined
    params = undefined
    cadena = $('#filtro_cursos').val()
    if !force and cadena.length < 3
      return
    params = titulo_cur: cadena
    $.get '/management/courses', params, ((data) ->
      $('#cuerpo_tabla_cursos').empty()
      filtrarCursos data
      return
    ), 'json'
    return

  #Recorre cada item de la data

  filtrarCursos = (data) ->
    res = undefined
    results = undefined
    results = []
    for res of data
      `res = res`
      results.push crearCurso(data[res])
    results

  #Crea la estructura de de una fila de curso

  crearCurso = (cur) ->
    celda1 = undefined
    celda2 = undefined
    celda3 = undefined
    celda4 = undefined
    celda5 = undefined
    celda6 = undefined
    cuerpo_tabla = undefined
    estado = undefined
    link_a = undefined
    link_b = undefined
    link_c = undefined
    tr = undefined
    cuerpo_tabla = $('#cuerpo_tabla_cursos')
    tr = document.createElement('tr')
    celda1 = document.createElement('td')
    celda1.appendChild document.createTextNode(cur.titulo)
    celda2 = document.createElement('td')
    celda2.appendChild document.createTextNode(cur.category.nombre)
    celda3 = document.createElement('td')


    tipo = undefined
    switch cur.tipo
      when 1
        tipo = 'Diplomado'
      when 2
        tipo = 'Maestría'
      else
        tipo = 'Doctorado'

    celda3.appendChild document.createTextNode(tipo)
    celda4 = document.createElement('td')
    link_a = document.createElement('a')
    link_a.href = '/management/courses/' + cur.id
    link_a.innerHTML = 'Ver'
    celda4.appendChild link_a
    celda5 = document.createElement('td')
    link_b = document.createElement('a')
    link_b.href = '/management/courses/' + cur.id + '/edit'
    link_b.innerHTML = 'Editar'
    celda5.appendChild link_b
    celda6 = document.createElement('td')
    link_c = document.createElement('a')
    link_c.href = '/management/courses/' + cur.id
    link_c.dataset.method = 'delete'
    link_c.rel = 'nofollow'
    link_c.innerHTML = 'Eliminar'
    celda6.appendChild link_c
    tr.appendChild celda1
    tr.appendChild celda2
    tr.appendChild celda3
    tr.appendChild celda4
    tr.appendChild celda5
    tr.appendChild celda6
    cuerpo_tabla.append $(tr)
    return

  return
