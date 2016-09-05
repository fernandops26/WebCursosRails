class Person < ActiveRecord::Base
  has_one :department
  belongs_to :user

  validates :nombres, presence: {message:"- No puede estar vacio"},length:{minimum:3 , message:"- Minimo 3 caracteres" }
	validates :ape_pat, presence: {message: "- No puede estar vacio"},length:{minimum:3 , message:"- Minimo 3 caracteres" }
	validates :ape_mat, presence: {message: "- No puede estar vacio"},length:{minimum:3 , message:"- Minimo 3 caracteres" }
	validates :dni, presence: {message: "- No puede estar vacio"},length:{is:8,message:'Debe tener exactamente 8 digitos'},numericality: { only_integer: true },uniqueness: true
	validates :sexo, presence: {message: "- Selecciona una opción"}
	validates :f_nacimiento, presence: {message: "- Indica cuando naciste"}
	validates :celular, presence: {message: "- No puede estar vacio"}
	validates :email, presence:{message: "- No puede estar vacio"}
	validates :direccion , presence:{message:"- No puede estar vacio"},length:{minimum:5 , message:"- Minimo 5 caracteres" }
	validates :profesion , presence:{message:"- No puede estar vacio"},length:{minimum:5 , message:"- Minimo 5 caracteres" }
	validates :grado_acad , presence:{message:"- No puede estar vacio"},length:{minimum:5 , message:"- Minimo 5 caracteres" }


end
