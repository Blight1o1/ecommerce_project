ActiveAdmin.register Game do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :score, :rating, game_genres_attributes: [:id, :game_id, :genre_id, :_destroy], game_platforms_attributes: [:id, :game_id, :platform_id, :_destroy]

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Game" do
      f.input :name
      f.input :description
      f.input :price
      f.input :score
      f.input :rating
      f.has_many :game_genres, allow_destroy: true do |n_f|
        n_f.input :genre
      end
      f.has_many :game_platforms, allow_destroy: true do |n_f|
        n_f.input :platform
      end
    end

    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :score, :rating]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
