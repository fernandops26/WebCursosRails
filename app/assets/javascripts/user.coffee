jQuery ->
		#almacenar todos lo combos
	combo_provincias=$('#user_person_province_id');
	combo_departamentos=$('#user_person_department_id');
	combo_distritos=$('#user_person_district_id');

	padre_cb_provincias=$(combo_provincias).parent().parent();
	padre_cb_distritos=$(combo_distritos).parent().parent();

	#ocultar combos(provincias,distritos)

	console.log(combo_provincias);
	console.log(combo_distritos);

	combo_provincias.hide();
	combo_distritos.hide();

	padre_cb_provincias.hide();
	padre_cb_distritos.hide();

		


	cont_provincias=combo_provincias.html();

	combo_departamentos.change ->
		dep_seleccionado= $('#user_person_department_id :selected').text()
		opciones_provincias=$(cont_provincias).filter("optgroup[label='#{dep_seleccionado}']").html()
		if opciones_provincias
			combo_provincias.html(opciones_provincias)
		else
			combo_provincias.empty();
		combo_provincias.show();
		padre_cb_provincias.show();


	cont_distritos=combo_distritos.html()
	combo_provincias.change ->
		prov_seleccionada=$('#user_person_province_id :selected').text()
		opciones_distritos=$(cont_distritos).filter("optgroup[label='#{prov_seleccionada}']").html()
		if(opciones_distritos)
			combo_distritos.html(opciones_distritos)
		else
			combo_distritos.html(opciones_distritos)
		combo_distritos.show();
		padre_cb_distritos.show();
	
				

