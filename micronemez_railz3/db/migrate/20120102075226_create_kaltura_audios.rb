class CreateKalturaAudios < ActiveRecord::Migration
  def change
    create_table :kaltura_audios do |t|
      t.string :mediaId
      t.string :mediaType
      t.string :accessControlId
      t.string :adminTags
      t.string :categories
      t.string :categoriesIds
      t.string :conversionQuality
      t.string :createdAt
      t.string :creditUrl
      t.string :creditUserName
      t.string :dataUrl
      t.string :description
      t.string :downloadUrl
      t.string :duration
      t.string :durationType
      t.string :endDate
      t.string :flavorParamsIds
      t.string :groupId
      t.string :height
      t.string :id
      t.string :licenseType
      t.string :mediaDate
      t.string :mediaType
      t.string :moderationCount
      t.string :moderationStatus
      t.string :msDuration
      t.string :name
      t.string :objectType
      t.string :partnerData
      t.string :partnerId
      t.string :plays
      t.string :rank
      t.string :searchProviderId
      t.string :searchProviderType
      t.string :searchText
      t.string :sourceType
      t.string :startDate
      t.string :status
      t.string :tags
      t.string :thumbnailUrl
      t.string :totalRank
      t.string :type
      t.string :updatedAt
      t.string :userId
      t.string :version
      t.string :views
      t.string :votes
      t.string :width

      t.timestamps
    end
  end
end
