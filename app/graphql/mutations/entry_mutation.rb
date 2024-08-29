# module Mutations
#   class EntryMutation < BaseMutation
#     description 'EntryMutation'
#     argument :description, String, required: true
#     argument :entry_type, String, required: false
#     argument :image, ApolloUploadServer::Upload, required: false

#     field :entry, Types::EntryType, null: true
#     field :errors, [String], null: false

#     def resolve(entry_type:, description:)
#       current_user = context[:current_user]

#       if current_user.present?
#         entry = Entry.new(
#           user_id: current_user.id,
#           description: description,
#           entry_type: entry_type
#         )

#         # if image.present?
#         #   entry.image.attach(io: image, filename: image.original_filename) # Adjunta la imagen al modelo Entry
#         # end

#         if entry.save
#           {
#             id: entry.id,
#             description: entry.description,
#             created_at: entry.created_at,
#             user: entry.user
#           }
#         else
#           {errors: ['Error on entry']}
#         end
#       else
#         {errors: ['Not logged']}
#       end
#     end
#   end
# end

