class ContactQuery < ActiveRecord::Base
	validates :nombres, presence: {message:"- No puede estar vacio"},length:{minimum:3 , message:"- Minimo 3 caracteres" }
	validates :apellidos, presence: {message: "- No puede estar vacio"}
	validates :email, presence:{message: "- No puede estar vacio"}
	validates :telefono , presence:{message:"- No puede estar vacio"}
	validates :mensaje , presence:{message:"- No puede estar vacio"}

	after_initialize :set_defaults

  private
  def set_defaults
    if self.new_record?
      self.leido ||= false
    end
  end
end
