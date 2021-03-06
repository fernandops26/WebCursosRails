class Person < ActiveRecord::Base
  belongs_to :district
  belongs_to :user
  has_many :subsidiaries ,dependent: :destroy
  has_many :programations, :through => :subsidiaries
  
  accepts_nested_attributes_for :subsidiaries, allow_destroy: true

  validates :nombres, presence: {message:"- No puede estar vacio"},length:{minimum:3 , message:"- Minimo 3 caracteres" }
	validates :ape_pat, presence: {message: "- No puede estar vacio"},length:{minimum:3 , message:"- Minimo 3 caracteres" }
	validates :ape_mat, presence: {message: "- No puede estar vacio"},length:{minimum:3 , message:"- Minimo 3 caracteres" }
	validates :dni, presence: {message: "- No puede estar vacio"},length:{is:8,message:'Debe tener exactamente 8 digitos'},numericality: { only_integer: true },uniqueness: {message: "Dni ya se ha registrado"}
	validates :sexo,:inclusion => { :in => [true, false] },:presence => { :if => 'sexo.nil?',message: "- Selecciona una opción" }
	validates :f_nacimiento, presence: {message: "- Indica cuando naciste"}
	validates :celular, presence: {message: "- No puede estar vacio"}
	validates :email, presence:{message: "- No puede estar vacio"}
	validates :direccion , presence:{message:"- No puede estar vacio"},length:{minimum:5 , message:"- Minimo 5 caracteres" }
	validates :profesion , presence:{message:"- No puede estar vacio"},length:{minimum:5 , message:"- Minimo 5 caracteres" }
	validates :grado_acad , presence:{message:"- No puede estar vacio"},length:{minimum:5 , message:"- Minimo 5 caracteres" }



 def self.buscar_prog(id_p)
 	puts "----------------------------------------------------"
 	puts "prog"+id_p.to_s
 	if !id_p.nil?
	 	prog=Programation.find(id_p)
	 	prog.course.titulo+" - "+prog.institution.razon 
 	else
 		""
 	end
 	
 end


end
