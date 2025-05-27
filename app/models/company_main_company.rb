class CompanyMainCompany < ApplicationRecord
  belongs_to :company
  belongs_to :main_company, class_name: "Company"
end
