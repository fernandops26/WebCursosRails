'use strict'
$(document).ready(function(){


  $('#panel-mensaje-detalle').hide();


	$('#filtro_mensajes_nombres').keyup(function(e) {
      clearTimeout($.data(this, 'timer'));
      if (e.keyCode === 13) {
        searchMnsjs(true);
      } else {
        $(this).data('timer', setTimeout(searchMnsjs, 500));
      }
    });


    //Busca coincidencias de 
    var searchMnsjs = function(force) {
      var cadena, params;
      cadena = $('#filtro_mensajes_nombres').val();
      if (!force && cadena.length < 3) {
        return;
      }
      params = {
        filtro_nombres: cadena
      };
      $.get('/management/contact', params, (function(data) {
        $('#mail-list').empty();
        filtrarMensajesNombres(data);
      }), 'json');
    };

    //Recorre cada item de la data de mensajes
    var filtrarMensajesNombres = function(data) {
      var res, results;
      results = [];
      for (res in data) {
        results.push(crearMensajeContact(data[res]));
      }
      return results;
    };

    //crea la estructura de un mensaje en la lista
    var crearMensajeContact=function(msj){
    	var lista_mensajes=$('#mail-list');
    	var li,a,span1,span2,span3,span4,link;
    	li=document.createElement('li');
    	li.className="mail-li";
    	a=document.createElement('a');
    	a.href="#";
    	a.dataset.id=msj.id;
    	a.className="mail-item";
    	span1=document.createElement('span');
    	span1.className="label label-nuevo";
    	span1.innerHTML="nuevo";
    	span2=document.createElement('span');
    	span2.className="mail-subject text-right";
    	span2.innerHTML=limpiarFechaMensaje(msj.created_at);
    	span3=document.createElement('span');
    	span3.className="mail-sender";
    	span3.innerHTML=msj.nombres +' '+msj.apellidos;
    	span4=document.createElement('span');
    	span4.className="mail-message-preview";
    	span4.innerHTML=msj.email;

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





	//Con respecto a la revision de mensajes(click a mensajes)
	
			$('.mail-list').on('click','.mail-item',function(){
			var id=$(this).data('id');
			$(this).parent().addClass('active');
			$(this).parent().siblings('.mail-li').removeClass('active');
			
			$.get('/management/contact/'+id, {}, (function(data) {
	        mostrarDetalleMensaje(data);
	      }), 'json');

      $('#panel-mensaje-detalle').show('400');
		});

	//Muestra el detalle de mensaje y actualiza su estado
	var mostrarDetalleMensaje=function(data){
		$('#mensaje-detalle_nombres').html(data.nombres +" " +data.apellidos);
		$('#mensaje-detalle_correo').html(data.email);
		$('#mensaje-detalle_telefono').html(data.telefono);
		$('#mensaje-detalle_mensaje').html(data.mensaje);

			if(data.leido==false){
				$.post('/management/contact/update_leido', {id: data.id,leido:true}, (function(data) {
			
					$.get('/management/contact', {filtro_nombres:''}, (function(data) {
		        $('#mail-list').empty();
		        filtrarMensajesNombres(data);
		      }), 'json');
		    }),'json');
			}
		
	}





});