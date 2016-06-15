class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      all_wikis = scope.all
      if user.admin?
        wikis = scope.all
      elsif user.premium?
        all_wikis.each do |wiki|
          if wiki_is_public?(wiki) || current_user_is_wiki_owner?(wiki) || current_user_is_collaborator?(wiki)
            wikis << wiki
          end
        end
      else
        all_wikis.each do |wiki|
          if wiki_is_public?(wiki) || current_user_is_collaborator?(wiki)
            wikis << wiki
          end
        end
      end
      wikis
    end

    private

    def wiki_is_public?(wiki)
      !wiki.private?
    end

    def current_user_is_wiki_owner?(wiki)
      wiki.user == user
    end

    def current_user_is_collaborator?(wiki)
      wiki.users.include?(user)
    end
  end
end