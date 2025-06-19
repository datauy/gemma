class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :company_main_companies, foreign_key: 'company_id'
  has_many :main_companies, through: :company_main_companies, foreign_key: 'main_company_id'
  accepts_nested_attributes_for :company_main_companies, :allow_destroy => true

  has_many :company_child_companies, foreign_key: 'main_company_id', class_name: 'CompanyMainCompany'


  has_many :evaluations

  has_one_attached :logo

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
    'Agroindustria',
    'Comercio',
    'Industria',
    'Servicios'
  ]
  enum :size, [
    'Empresa chica (hasta 20 empleados)',
    'Empresa mediana (desde 20 empleados hasta 50)',
    'Empresa grande (desde 50 empleados)'
  ]

  def self.ransackable_attributes(auth_object = nil)
    ["activity", "address", "contact_email", "contact_name", "contact_position", "contact_tel", "created_at", "email", "encrypted_password", "fake_name", "id", "is_confirmed", "is_main_company", "man_workers", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "size", "start_year", "state", "updated_at", "woman_workers"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["company", "company_main_companies"]
  end

  def after_confirmation
    AdminMailer.with(company: self).new_company.deliver
  end
end
