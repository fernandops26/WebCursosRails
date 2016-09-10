'use strict'
$(document).ready(function(){
	$('#filtro_mensajes_nombres-sub').keyup(function(e) {
      clearTimeout($.data(this, 'timer'));
      if (e.keyCode === 13) {
        searchMnsjsSub(true);
      } else {
        $(this).data('timer', setTimeout(searchMnsjsSub, 500));
      }
    });


    //Busca coincidencias de 
    var searchMnsjsSub = function(force) {
      var cadena, params;
      cadena = $('#filtro_mensajes_nombres-sub').val();
      if (!force && cadena.length < 3) {
        return;
      }
      params = {
        filtro_nombres: cadena
      };
      $.get('/management/subsidiaries', params, (function(data) {
        $('#mail-list-sub').empty();
        filtrarMensajesNombresSub(data);
      }), 'json');
    };

    //Recorre cada item de la data de mensajes
    var filtrarMensajesNombresSub = function(data) {
      var res, results;
      results = [];
      for (res in data) {
        results.push(crearMensajeSub(data[res]));
      }
      return results;
    };

    //crea la estructura de un mensaje en la lista
    var crearMensajeSub=function(msj){
    	var lista_mensajes=$('#mail-list-sub');
    	var li,a,span1,span2,span3,span4,link;
    	li=document.createElement('li');
    	li.className="mail-li";
    	a=document.createElement('a');
    	a.href="#";
    	a.dataset.id=msj.id;
    	a.className="mail-item-sub";
    	span1=document.createElement('span');
    	span1.className="label label-nuevo";
    	span1.innerHTML="nuevo";
    	span2=document.createElement('span');
    	span2.className="mail-subject-sub text-right";
    	span2.innerHTML=limpiarFechaMensaje(msj.created_at);
    	span3=document.createElement('span');
    	span3.className="mail-sender-sub";
    	span3.innerHTML=msj.person.nombres +' '+msj.person.ape_pat+' '+msj.person.ape_mat;
    	span4=document.createElement('span');
    	span4.className="mail-message-preview-sub";
    	span4.innerHTML=msj.person.email;

    	if(msj.leido==false){
    		a.appendChild(span1);
    	}
    	a.appendChild(span2);
    	a.appendChild(span3);
    	a.appendChild(span4);
    	li.appendChild(a);

    	lista_mensajes.append($(li));
    }

    //limpia la fehca regresando un determinado formato
    var limpiarFechaMensaje=function(fecha){
    	return moment(fecha).format('DD/MM/YYYY') + " - " + moment(fecha).format('	hh:mm:ss A');
    };

    $('#panel-mensaje-detalle-sub').hide();



	//Con respecto a la revision de mensajes(click a mensajes)
	
			$('.mail-list-sub').on('click','.mail-item-sub',function(){
			var id=$(this).data('id');
			$(this).parent().addClass('active');
			$(this).parent().siblings('.mail-li-sub').removeClass('active');
			
			$.get('/management/subsidiaries/'+id, {}, (function(data) {
	        mostrarDetalleMensaje(data);
	      }), 'json');

      $('#panel-mensaje-detalle-sub').show('400');
		});

	//Muestra el detalle de mensaje y actualiza su estado
	var mostrarDetalleMensaje=function(data){
		$('#mensaje-detalle_nombres-sub').html(data.person.nombres +" " +data.person.ape_pat +" "+data.person.ape_mat);
		$('#mensaje-detalle_correo-sub').html(data.person.email);
		$('#mensaje-detalle_telefono-sub').html(data.person.celular);
    $('#detalle-registro-fecha-n').html(data.person.f_nacimiento);
    $('#detalle-registro-dni').html(data.person.dni);
    $('#detalle-registro-celular').html(data.person.celular);
    $('#detalle-registro-genero').html(data.person.genero);
    $('#detalle-registro-ubicacion').html(retornarUbicacion(data.person));
    $('#detalle-registro-direccion').html(data.person.direccion);
    $('#detalle-registro-profesion').html(data.person.profesion);
    $('#detalle-registro-grado').html(data.person.grado_acad);
    $('#detalle-registro-curso').html(data.programation.course.titulo);
    $('#detalle-registro-institucion').html(data.programation.institution.razon);
    $('#detalle-registro-curso').html(data.programation.course.titulo);
    $('#detalle-registro-costo').html(data.programation.costo);

    $('#detalle-registro-id').val(data.id);
    $('#detalle-registro-leido').val(data.leido);
    $('#detalle-registro-btn-leido').attr('data-index', data.id);
    
	
	}



  $('#detalle-registro-btn-leido').on('click',function(event) {
    event.preventDefault();
    var id_a,id_b,leido;
    id_a=$('#detalle-registro-id').val();
    id_b=$('#detalle-registro-btn-leido').attr('data-index');
    leido=$('#detalle-registro-leido').val();

    if(id_a==id_b){
      if(leido=='false'){
        $.post('/management/subsidiaries/update_leido', {id: id_a,leido:true}, (function(data) {
      
          $.get('/management/subsidiaries', {filtro_nombres:''}, (function(data) {
            $('#mail-list-sub').empty();
            filtrarMensajesNombresSub(data);
          }), 'json');
        }),'json');
      }

    }else{
    }

  });

  var retornarUbicacion=function(person){
    var department=capitalizeFirstLetter(person.district.province.department.nombredep.toLowerCase());
    var province=capitalizeFirstLetter(person.district.province.nombreprov.toLowerCase());
    var district=capitalizeFirstLetter(person.district.nombredist.toLowerCase());

    var todo=department+"/"+province+"/"+district;
    return todo
  }

  function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}




});