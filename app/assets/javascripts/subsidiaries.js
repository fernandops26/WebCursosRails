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
    var tipo_curso="";
		$('#mensaje-detalle_nombres-sub').html(data.person.nombres +" " +data.person.ape_pat +" "+data.person.ape_mat);
		$('#mensaje-detalle_correo-sub').html(data.person.email);
		$('#mensaje-detalle_telefono-sub').html(data.person.celular);
    $('#detalle-registro-celular').html(data.person.celular);
    if(data.person.celular_op){
      $('#mensaje-detalle_telefono-sub').html(data.person.celular+" // "+data.person.celular_op);
       $('#detalle-registro-celular').html(data.person.celular+" // "+data.person.celular_op);
    }
    $('#detalle-registro-nombres').html(data.person.nombres)
    $('#detalle-registro-fecha-n').html(data.person.f_nacimiento);
    $('#detalle-registro-dni').html(data.person.dni);
    $('#detalle-registro-genero').html(data.person.genero);
    $('#detalle-registro-ubicacion').html(retornarUbicacion(data.person));
    $('#detalle-registro-direccion').html(data.person.direccion);
    $('#detalle-registro-profesion').html(data.person.profesion);
    $('#detalle-registro-grado').html(data.person.grado_acad);
    if(data.programation !=null){
      $('#detalle-registro-institucion').html(data.programation.institution.razon);
      $('#detalle-registro-curso').html(data.programation.course.titulo);
    }else{
      $('#detalle-registro-institucion').html('no asignado');
      $('#detalle-registro-curso').html('no asignado');

    }


    if(data.programation!=null){
      if(data.programation.course.tipo=='1'){
        tipo_curso='Diplomado';
      }else if(data.programation.course.tipo=='2'){
        tipo_curso='Maestria';
      }else if(data.programation.course.tipo=='3'){
        tipo_curso='Doctorado'
      }else{
        tipo_curso='No identificado'
      }
      $('#detalle-registro-tipo').html(tipo_curso);
      $('#detalle-registro-costo-matricula').html(data.programation.costo_matricula);
      $('#detalle-registro-costo-mensualidad').html(data.programation.costo_mensualidad);
      $('#detalle-registro-costo-certificacion').html(data.programation.costo_certificacion);
    }else{
      $('#detalle-registro-tipo').html('no asignado');
      $('#detalle-registro-costo-matricula').html('no signado');
      $('#detalle-registro-costo-mensualidad').html('no signado');
      $('#detalle-registro-costo-certificacion').html('no signado');
    }


    if(data.person.user==null){
      $('#detalle-registro-usuario').addClass('label label-success');
      $('#detalle-registro-usuario').removeClass('label-danger');
      $('#detalle-registro-usuario').html('Nuevo');
      $('#detalle-registro-btn-asignar').show();
      $('#detalle-registro-btn-ver').hide();
    }else{
      $('#detalle-registro-usuario').addClass('label label-danger');
      $('#detalle-registro-usuario').removeClass('label-success');
      $('#detalle-registro-usuario').html('Ya existente');
      $('#detalle-registro-btn-asignar').hide();
      $('#detalle-registro-btn-ver').attr('href', '/management/users/'+data.person.user.id);
      $('#detalle-registro-btn-ver').show();
    }

    if(data.estado==true){
      $('#detalle-registro-btn-cancelar-matricula').show();
      $('#detalle-registro-btn-aceptar-matricula').hide();
    }else{
      $('#detalle-registro-btn-cancelar-matricula').hide();
      $('#detalle-registro-btn-aceptar-matricula').show();
    }

    $('#detalle-registro-id').val(data.id);
    $('#detalle-registro-leido').val(data.leido);
    $('#detalle-registro-btn-leido').attr('data-index', data.id);
    $('#detalle-registro-btn-guardar').attr('data-person', data.person.id);

    $('#detalle-registro-btn-aceptar-matricula').attr('data-index', data.id);
    $('#detalle-registro-btn-cancelar-matricula').attr('data-index', data.id);

    
	
	}

//Boton que marca un objeto subsidiary como leido
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

  $('#detalle-registro-btn-aceptar-matricula').on('click',function(event) {
    event.preventDefault();
    var id_a,id_b;
    id_a=$('#detalle-registro-id').val();
    id_b=$(this).attr('data-index');

    if(id_a==id_b){
        $.post('/management/subsidiaries/update_estado', {id: id_a,estado:true}, (function(data) {
      
            mostrarDetalleMensaje(data);
          }), 'json');
    }else{
    }

  });


  $('#detalle-registro-btn-cancelar-matricula').on('click',function(event) {
    event.preventDefault();
    var id_a,id_b;
    id_a=$('#detalle-registro-id').val();
    id_b=$(this).attr('data-index');

    if(id_a==id_b){
        $.post('/management/subsidiaries/update_estado', {id: id_a,estado:false}, (function(data) {
            mostrarDetalleMensaje(data);
          }), 'json');
    }else{
    }

  });

//Genera usuario y contaseña aleatoriamente
  $('#detalle-registro-btn-generar').on('click',function(event) {
    event.preventDefault();
    var caracteres,longitud,username,passwords;
    caracteres = $('#mensaje-detalle_nombres-sub').html().replace(/\s/g, "")+"1234567890";
    caracteres.trim();
    longitud = 10;
    username=rand_code(caracteres, longitud);
    passwords=rand_code(caracteres, longitud);
    $('#user_username').val(username);
    $('#user_password').val(passwords);
    $('#user_password_digest').val(passwords);
    

  });

  $('#detalle-registro-btn-asignar').on('click', function(event) {
    event.preventDefault();
    $('#cuerpo-mensajes-sub').hide('fast');
    $('#detalle--datos-acceso-sub').show('slow');
    $('.ofuscador-de-fondo').show('fast');
  });

  $('#detalle-registro-btn-cancelar').on('click', function(event) {
    event.preventDefault();
    $('#cuerpo-mensajes-sub').show('slow');
    $('#detalle--datos-acceso-sub').hide('fast');
    $('.ofuscador-de-fondo').hide('fast');
  });

    $('#detalle-registro-btn-guardar').on('click',function(event) {
      var id,params,username,password,password_digest,id_subsidiary;
      id=$(this).attr('data-person');
      username=$('#user_username').val();
      password=$('#user_password').val();
      password_digest=$('#user_password_digest').val();
      id_subsidiary=$('#detalle-registro-btn-leido').attr('data-index');
      params={
        id:id,
        username:username,
        password:password,
        password_digest:password_digest,
        id_subsidiary:id_subsidiary
      }
      $.post('/management/subsidiaries/update_credential', params, (function(data) {
        mostrarDetalleMensaje(data);

        $('#user_username').val('');
        $('#user_password').val('');
        $('#user_password_digest').val('');
        $('#cuerpo-mensajes-sub').show('slow');
        $('#detalle--datos-acceso-sub').hide('fast');
        $('.ofuscador-de-fondo').hide('fast');
      }),'json');
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


function rand_code(chars, lon){
  var code = "";
    for (var x=0; x < lon; x++)
    {
      var rand = Math.floor(Math.random()*chars.length);
        code += chars.substr(rand, 1);
      
    }
      code.replace(/^\s+|\s+$/g, "0");
  return code;
}





});