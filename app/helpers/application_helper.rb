module ApplicationHelper

    #f.objectで@userを取得、.classでモデルであるUserを取得
    #.klassでモデル（Education）を取得、newでEducation.new

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    # id = f.object.send(association).length

    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
