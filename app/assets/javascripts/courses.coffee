
'use strict'
console.log $('#filtro_cursos')
$(document).ready ->
  #Evento al presionar tecla 
  $('#filtro_cursos').keyup (e) ->
    console.log e
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
    $.get '/courses', { titulo_cur: cadena }, ((data) ->
	  			console.log(data)
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
    celda7 = undefined
    celda8 = undefined
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
    celda2.appendChild document.createTextNode(cur.contenido)
    celda3 = document.createElement('td')
    celda3.appendChild document.createTextNode(cur.category.nombre)
    celda4 = document.createElement('td')
    celda4.appendChild document.createTextNode(cur.fecha)
    celda5 = document.createElement('td')
    estado = '-'
    if cur.estado == true
      estado = 'Activo'
    else
      estado = 'Inactivo'
    celda5.appendChild document.createTextNode(estado)
    celda6 = document.createElement('td')
    link_a = document.createElement('a')
    link_a.href = '/courses/' + cur.id
    link_a.innerHTML = 'Ver'
    celda6.appendChild link_a
    celda7 = document.createElement('td')
    link_b = document.createElement('a')
    link_b.href = '/courses/' + cur.id + '/edit'
    link_b.innerHTML = 'Editar'
    celda7.appendChild link_b
    celda8 = document.createElement('td')
    link_c = document.createElement('a')
    link_c.href = '/courses/' + cur.id
    link_c.dataset.method = 'delete'
    link_c.rel = 'nofollow'
    link_c.innerHTML = 'Eliminar'
    celda8.appendChild link_c
    tr.appendChild celda1
    tr.appendChild celda2
    tr.appendChild celda3
    tr.appendChild celda4
    tr.appendChild celda5
    tr.appendChild celda6
    tr.appendChild celda7
    tr.appendChild celda8
    cuerpo_tabla.append $(tr)
    return

  return
