# frozen_string_literal: true

class ApplicationPolicy
  include AdminUser

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def avo_index?
    false
  end

  def avo_show?
    false
  end

  def avo_create?
    false
  end

  def avo_new?
    avo_create?
  end

  def avo_update?
    false
  end

  def avo_edit?
    avo_update?
  end

  def avo_destroy?
    false
  end

  def avo_search?
    avo_index?
  end

  def self.has_association(assocation) # rubocop:disable Naming/PredicateName
    %w[create attach detach destroy edit].each do |action|
      define_method(:"#{action}_#{assocation}?") { false }
    end
    define_method(:"show_#{assocation}?") { Pundit.policy!(user, record).avo_show? }
    alias_method :"view_#{assocation}?", :avo_show?
  end

  class Scope
    include AdminUser

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
