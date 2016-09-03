'use strict'
console.log($('#filtro_categoria'));
$(document).ready(function(){

	//Evento al presionar tecla 
	$('#filtro_categoria').keyup(function(e) {
      clearTimeout($.data(this, 'timer'));
      if (e.keyCode === 13) {
        search(true);
      } else {
        $(this).data('timer', setTimeout(search, 500));
      }
    });

	//Busca coincidencias de categorias
    var search = function(force) {
      var cadena, params;
      cadena = $('#filtro_categoria').val();
      if (!force && cadena.length < 3) {
        return;
      }
      params = {
        nombre_cat: cadena
      };
      $.get('/categories', {
        nombre_cat: cadena
      }, (function(data) {
        $('#cuerpo_tabla_categorias').empty();
        filtrarCategorias(data);
      }), 'json');
    };

    //Recorre cada item de la data
    var filtrarCategorias = function(data) {
      var res, results;
      results = [];
      for (res in data) {
        results.push(crearCategoria(data[res]));
      }
      return results;
    };

    //Crea la estructura de de una fila de categoria
    var crearCategoria = function(cat) {
      var celda1, celda2, celda3, celda4, celda5, celda6, cuerpo_tabla, estado, link_a, link_b, link_c, tr;
      cuerpo_tabla = $('#cuerpo_tabla_categorias');
      tr = document.createElement('tr');
      celda1 = document.createElement('td');
      celda1.appendChild(document.createTextNode(cat.nombre));
      celda2 = document.createElement('td');
      celda2.appendChild(document.createTextNode(cat.descripcion));
      celda3 = document.createElement('td');
      estado = '-';
      if (cat.estado === true) {
        estado = 'Activo';
      } else {
        estado = 'Inactivo';
      }
      celda3.appendChild(document.createTextNode(estado));
      celda4 = document.createElement('td');
      link_a = document.createElement('a');
      link_a.href = '/categories/' + cat.id;
      link_a.innerHTML = 'Ver';
      celda4.appendChild(link_a);
      celda5 = document.createElement('td');
      link_b = document.createElement('a');
      link_b.href = '/categories/' + cat.id + '/edit';
      link_b.innerHTML = 'Editar';
      celda5.appendChild(link_b);
      celda6 = document.createElement('td');
      link_c = document.createElement('a');
      link_c.href = '/categories/' + cat.id;
      link_c.dataset.method = 'delete';
      link_c.rel = 'nofollow';
      link_c.innerHTML = 'Eliminar';
      celda6.appendChild(link_c);
      tr.appendChild(celda1);
      tr.appendChild(celda2);
      tr.appendChild(celda3);
      tr.appendChild(celda4);
      tr.appendChild(celda5);
      tr.appendChild(celda6);
      cuerpo_tabla.append($(tr));
    };

    //Extrae data de las categorias existentes e
    //Inicializa selectize con opciones
    var lista = $('#lista_categorias');
      return $.get('/categories', {
        nombre_cat: ''
      }, (function(data) {
      	var cat_destacadas=limpiarDatosCategorias(data,2);
        var opciones_activas=limpiarDatosCategorias(data,1);

        lista.selectize({
          create: false,
          valueField: 'id',
          labelField: 'nombre',
          searchField: 'nombre',
          maxItems: 6,
          maxOptions: 4,
          options: opciones_activas,
          items:cat_destacadas,
          onItemRemove:function(id_item){
          	$.post('/categories/update_destacar', {id: id_item,destacar:false}, (function(data) {

          	}),'json');
	        this.refreshItems()
          },
          onItemAdd:function(id_item,item){
	        $.post('/categories/update_destacar', {id: id_item,destacar:true}, (function(data) {
          		
          	}),'json');
          	this.refreshItems()
          },
          onChange:function(){

          }
        });

      }), 'json');

});

//Limpia la data para obtener solo las categorias destacadas
var limpiarDatosCategorias=function(data,accion){
	var obj=[];
  if(accion==1){
    for(var i=0;i<data.length;i++){
      
      if(data[i].estado==true){
        //Se requiren el objeto completo
        obj.push(data[i]);
      }
    }
  }else{
    for(var i=0;i<data.length;i++){
      if(data[i].destacar==true && data[i].estado==true){
        //Se requiren solo los id's
        obj.push(data[i].id);
      }
    }
  }
	return obj;
}




 