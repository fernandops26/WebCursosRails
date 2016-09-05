'use strict'
console.log($('#filtro_categoria'));
$(document).ready(function(){

	//Evento al presionar tecla 
	$('#filtro_institucion').keyup(function(e) {
      clearTimeout($.data(this, 'timer'));
      if (e.keyCode === 13) {
        searchInst(true);
      } else {
        $(this).data('timer', setTimeout(searchInst, 500));
      }
    });

	//Busca coincidencias de categorias
    var searchInst = function(force) {
      var cadena, params;
      cadena = $('#filtro_institucion').val();
      if (!force && cadena.length < 3) {
        return;
      }
      params = {
        razon: cadena
      };
      $.get('/management/institutions', params, (function(data) {
        $('#cuerpo_tabla_instituciones').empty();
        filtrarInstituciones(data);
      }), 'json');
    };

    //Recorre cada item de la data
    var filtrarInstituciones = function(data) {
      var res, results;
      results = [];
      for (res in data) {
        results.push(crearCategoria(data[res]));
      }
      return results;
    };

    var crearCategoria = function(inst) {
      var celda1, celda2, celda3, celda4, cuerpo_tabla, link_a, link_b, link_c, tr;
      cuerpo_tabla = $('#cuerpo_tabla_instituciones');
      tr = document.createElement('tr');
      celda1 = document.createElement('td');
      celda1.appendChild(document.createTextNode(inst.razon));
      celda2 = document.createElement('td');
      link_a = document.createElement('a');
      link_a.href = '/management/institutions/' + inst.id;
      link_a.innerHTML = 'Ver';
      celda2.appendChild(link_a);
      celda3 = document.createElement('td');
      link_b = document.createElement('a');
      link_b.href = '/management/institutions/' + inst.id + '/edit';
      link_b.innerHTML = 'Editar';
      celda3.appendChild(link_b);
      celda4 = document.createElement('td');
      link_c = document.createElement('a');
      link_c.href = '/management/institutions/' + inst.id;
      link_c.dataset.method = 'delete';
      link_c.dataset.confirm='¿Estas seguro?';
      link_c.rel = 'nofollow';
      link_c.innerHTML = 'Eliminar';
      celda4.appendChild(link_c);
      tr.appendChild(celda1);
      tr.appendChild(celda2);
      tr.appendChild(celda3);
      tr.appendChild(celda4);
      cuerpo_tabla.append($(tr));
  	};

});