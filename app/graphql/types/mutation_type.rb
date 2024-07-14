# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_auth, Types::AuthType, mutation: Mutations::AuthMutation
    field :create_contact_us, Types::ContactUsType, mutation: Mutations::CreateContactUs
    field :create_comment, Types::CommentType, mutation: Mutations::CommentMutation
    # field :create_entry, Types::EntryType, mutation: Mutations::EntryMutation
    field :logout, mutation: Mutations::LogoutMutation
    field :create_note, Types::NoteType, mutation: Mutations::NoteMutation
    field :createConversation, Types::ConversationType, mutation: Mutations::ConversationMutation
  end
end
