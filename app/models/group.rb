class Group < ApplicationRecord
    validates_presence_of :name, :maxMember, :university, :course, :term
    validates_inclusion_of :maxMember, :in => 2..999
end
