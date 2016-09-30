'use strict';
$(document).ready(function() {
	/*

  // Listen for the demographic changing
  $('#people_categories').change(function(){

    // Grab the id of currenly selected demographic
    var tipo_id,category_id,params;
	    tipo_id = $('#tipo').val();
	    category_id = $(this).val();

	    // Query the responses for this demographic:
	    params={
	    	tipo_curso:tipo_id,
	    	category_id:category_id
	    };
    
    console.log(params)
    $.get( "/management/people/obtener_cursos", params, (function( data ) {
    	console.log(data);

      // Remove the existing options in the responses drop down:
      //$("#responses").html("");

      // Loop over the json and populate the Responses options:
      /**
      $.each( data, function( index, value ) {
        $("#responses").append( "<option value='" + value.id + "'>" + value.name + "</option>" );
      });*/
/*
    }), 'json');
  });
	*/

	$(document).on("fields_added.nested_form_fields",function(event, param){

		var peo_cat=$('.people_categories');

		$('.person_form1').on('change', '.people_categories', function(event) {
			iniciar_selectize(this);
		});

		peo_cat.change();
	});

	//Seleccionar combo categorias
	$('.person_form1').on('change', '.people_categories', function(event) {
		iniciar_selectize(this);
	});

	//Seleccionar tipo curso
	$('.person_form1').on('change','.people_cursos_tipo',function(event){
		$('.people_categories').change();
	});

	/*
	$('#new_person').on('change', '.people_cursos', function(event) {
			$(this).siblings('.people_categories').change();
	});*/

	$('.person_form1').on('change', '.people_programations', function(event) {
		var id_programacion,prog_id_hidden,prog_full_name;
			id_programacion=$(this).val();
		var card_block=$(this).parent().parent().parent().siblings('.card-block')
			prog_full_name=card_block.find('.people_programation_full');

			$.get('/people/obtener_programacion', {programacion_id:id_programacion}, (function(data) {
				prog_full_name.val(data.course.titulo +" - "+data.institution.razon);
      		}), 'json');



		
		prog_id_hidden=card_block.find('.people_programation_hidden');
		prog_id_hidden.val(id_programacion);
		


	});

	//Click para cambiar de curso seleccionado
	$('.person_form1').on('click','.people_programation_change',function(event){
		event.preventDefault();
		var cont_program=$(this).parent().parent().parent().siblings('.card-block').children('.card-contenedor-cambio-curso');

		cont_program.toggle();
	});





$('.people_programations').hide();


var iniciar_selectize=function(combo_categoria){

	var cat,t_curso,combo,caja_program,opciones;
	combo=$(combo_categoria);

	caja_program=combo.siblings('.people_programations');

	cat=combo.val();
	t_curso=combo.siblings('.people_cursos_tipo').val();

	$.get('/people/obtener_cursos', {categoria:cat,tipo_curso:t_curso}, (function(data) {

			if(data.length){
				caja_program.selectize({
					create: false,
			    valueField: 'id',
			    labelField: 'course.titulo',
			    searchField: 'course.titulo',
			    maxItems: 1,
			    options:data,
			    render:{
			    	item:function(data){
			    		 return "<div data-value='"+data.id+"' class='option'>"+data.course.titulo+"-"+data.institution.razon+" </div>";
			    	},
			    	option: function(item, escape) {
	             return "<div data-value='"+item.id+"' class='option'>"+item.course.titulo+"-"+item.institution.razon+" </div>";
	        	}
			    }

				});

			}else{
				caja_program.hide();
			}


    }), 'json');

};


var user_id_people=$('.people_user_id_form');

if(user_id_people){
	var id=user_id_people.val();
	var params={

	}

	if(id!=""){
		params.id_user_edit=id;
	}

	$.get('/people/obtener_usuarios', params, (function(data) {

		user_id_people.selectize({
			create: false,
		    valueField: 'id',
		    labelField: 'username',
		    searchField: 'username',
		    maxItems: 1,
		    options:data,
		    maxOptions:3
		});


	}));
}
/*
$('#new_person').on('keyup','.people_programations',function(){

	var cat,t_curso;
		cat=$(this).siblings('.people_categories').val();
		t_curso=$(this).siblings('.people_cursos_tipo').val();
		console.log($(this).val());

	//var opciones=opciones_programacion(cat,t_curso);

	$(this).selectize({
		create: false,
    valueField: 'id',
    labelField: 'nombre',
    searchField: 'nombre',
    maxItems: 1

	});
});*/
/*

	var opciones_programacion=function(categoria,tipo_curso){

		$.get('/people/obtener_cursos', {categoria:categoria,tipo_curso:tipo}, (function(data) {
			console.log(data);
			/*
				$(self).siblings('.people_courses').empty();
				if(data.length>0){

					$.each( data, function( index, value ) {
						$(self).siblings('.people_courses').empty();
				        $(self).siblings('.people_courses').append( "<option value='" + value.id + "'>" + value.titulo + "</option>" );
				    });
					}else{
						 $(self).siblings('.people_courses').append( "<option value='"  + "'>" + "Ningún resultado" + "</option>" );
					}


      	}), 'json');
	};*/

/*
	$('#new_person').on('change','.people_cursos_tipo',function(event){
		$(this).siblings('.people_categories').change();
		$(this).siblings('.people_courses').change();
	});

	$('#new_person').on('change','.people_courses',function(event){
		//$(this).siblings('.people_categories').change();
		var curso_id;
			curso_id=$(this).val();

		$.get('/people/obtener_programaciones', {curso:curso_id}, (function(data) {
				$(self).siblings('.people_programation').empty();
				console.log(data);
				if(data.length>0){

					$.each( data, function( index, value ) {
						$(self).siblings('.people_programation').empty();
				        $(self).siblings('.people_programation').append( "<option value='" + value.id + "'>" + value.institution.razon + "</option>" );
				    });
					}else{
						 $(self).siblings('.people_programation').append( "<option value='"  + "'>" + "Ningún resultado" + "</option>" );
					}
      	}), 'json');

	});*/
});