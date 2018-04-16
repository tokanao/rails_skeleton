# ref. http://pocke.hatenablog.com/entry/2016/01/16/155004
namespace :db do
  # desc 'Generate model files from db schema'
  desc 'スキーマからモデルを生成'
  task gen: :environment do
    module ModelGenerator
      Models = {}
      module Evaluator
        module_function

        def create_table(table_name, *)
          Models[table_name.classify] = {
            has_many: [],
            belongs_to: [],
          }
        end

        # 無視
        def add_index(*) end
        def add_foreign_key(from, to)
          fromc, toc = from.classify, to.classify
          Models[fromc][:belongs_to].push to.singularize
          Models[toc][:has_many].push from
        end
      end

      def self.save
        Models.each do |klass, data|
          code = [
            "class #{klass} < ApplicationRecord",
            data[:has_many].map{|x| "  has_many :#{x}"},
            data[:belongs_to].map{|x| "  belongs_to :#{x}"},
            "end\n",
          ].flatten.join("\n")
          path = Rails.root.join('app', 'models', "#{klass.underscore}.rb")

          debugger
          File.write(path, code) unless File.exist?(path)
        end
      end
    end

    s = ActiveRecord::Schema
    def s.define(*, &block)
      ModelGenerator::Evaluator.class_eval(&block)
    end

    load Rails.root.join('db', 'schema.rb')

    ModelGenerator.save
  end

  desc 'seed データのdump'
  task seed_dump: :environment do
    target_tables.each do |table|
      model = table.classify.constantize
      puts "#{model} - #{model.all.size}"

      next if model.all.empty?

      SeedFu::Writer.write("db/fixtures/#{table}.rb", class_name: table.classify) do |writer|
        model.order(:id).find_each do |rec|
          edit_attrs = rec.attributes
          edit_attrs.delete("deleted_at")
          edit_attrs.each_pair do |key, val|
            if edit_attrs[key].is_a?(ActiveSupport::TimeWithZone) || edit_attrs[key].is_a?(Date)
              edit_attrs[key] = edit_attrs[key].to_s
            end
          end
          writer << edit_attrs
        end
      end
    end
  end

  def target_tables
    %w[systems customers]
  end
end
