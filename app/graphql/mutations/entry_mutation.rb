module Mutations
  class EntryMutation < BaseMutation
    description 'EntryMutation'
    argument :description, String, required: true
    argument :entry_type, String, required: false

    field :entry, Types::EntryType, null: true
    field :errors, [String], null: false

    def resolve(entry_type:, description:)
      current_user = context[:current_user]

      if current_user.present?
        entry = Entry.new(
          user_id: current_user.id,
          description: description,
          entry_type: entry_type
        )

        if entry.save
          {
            id: entry.id,
            description: entry.description,
            created_at: entry.created_at.strftime('%b %-d at %I:%H %P'),
            user: entry.user
          }
        else
          {errors: ['Error on entry']}
        end
      else
        {errors: ['Not logged']}
      end
    end
  end
end

