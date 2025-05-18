class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :company_main_companies
  has_many :companies, through: :company_main_companies

  enum :state, [
    'Artigas',
    'Canelones',
    'Cerro Largo',
    'Colonia',
    'Durazno',
    'Flores',
    'Florida',
    'Lavalleja',
    'Maldonado',
    'Montevideo',
    'Paysandú',
    'Río Negro',
    'Rivera',
    'Rocha',
    'Salto',
    'San José',
    'Soriano',
    'Tacuarembó',
    'Treinta y Tres'
  ]
  enum :activity, [
    'Actividad 1',
    'Actividad 2'
  ]
  enum :size, [
    'Empresa chica (hasta 20 empleados)',
    'Empresa mediana (desde 20 empleados hasta 50)',
    'Empresa grande (más de 50 empleados)'
  ]

  def self.ransackable_attributes(auth_object = nil)
    ["activity", "address", "contact_email", "contact_name", "contact_position", "contact_tel", "created_at", "email", "encrypted_password", "fake_name", "id", "is_confirmed", "is_main_company", "man_workers", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "size", "start_year", "state", "updated_at", "woman_workers"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["company", "company_main_companies"]
  end

end
