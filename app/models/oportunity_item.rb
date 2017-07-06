class OportunityItem < ApplicationRecord
	belongs_to :oportunity, foreign_key: :oportunity_identification,primary_key: :identification
end
