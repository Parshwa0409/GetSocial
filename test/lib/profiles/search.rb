require 'minitest/autorun'
require 'test/unit'
require '/Users/pbpatil/Desktop/GetSocial/test/test_helper.rb'
require_relative '/Users/pbpatil/Desktop/GetSocial/lib/profiles/search.rb'

describe Profiles::Search do

    subject { Profiles::Search }

    
    let(:user_where_result_mock) do
        mock = Minitest::Mock.new
        mock.expect(:includes, [], [:profile_picture_attachment])
        mock
    end


    let(:name_params) do
        { name:"Parshwa" }
    end

    let(:email_params) do
        { email:"parshwapatil9@gmail.com" }
    end

    let(:params) do 
        { name: "Parshwa", email: "parshwapatil9@gmail.com" }
    end

    describe 'SEARCH RECORD WITH BOTH NAME & EMAIL' do 
        let(:user_class_mock) do 
            mock = Minitest::Mock.new
            
            mock.expect(:where, user_where_result_mock, [
                "name LIKE ? OR email LIKE ?", 
                "%#{params[:name]}%", 
                "%#{params[:email]}%"
            ])
    
            mock
        end


        it 'test initialize' do
            test_obj = subject.new(params, user_class_mock)
            assert_instance_of Profiles::Search, test_obj
        end

        it 'tests the search feature' do
            test_obj = subject.new(params, user_class_mock)
            queried_users = test_obj.execute
            assert queried_users, []
        end
    end

    describe 'SEARCH RECORD WITH ONLY NAME' do 
        let(:user_class_mock) do 
            mock = Minitest::Mock.new
            
            mock.expect(:where, user_where_result_mock, [
                "name LIKE ?", 
                "%#{params[:name]}%"
            ])
    
            mock
        end


        it 'test initialize' do
            test_obj = subject.new(name_params, user_class_mock)
            assert_instance_of Profiles::Search, test_obj
        end

        it 'tests the search feature' do
            test_obj = subject.new(name_params, user_class_mock)
            queried_users = test_obj.execute
            assert queried_users, []
        end
    end

    describe 'SEARCH RECORD WITH ONLY EMAIL' do 
        let(:user_class_mock) do 
            mock = Minitest::Mock.new
            
            mock.expect(:where, user_where_result_mock, [
                "email LIKE ?", 
                "%#{params[:email]}%"
            ])
    
            mock
        end


        it 'test initialize' do
            test_obj = subject.new(email_params, user_class_mock)
            assert_instance_of Profiles::Search, test_obj
        end

        it 'tests the search feature' do
            test_obj = subject.new(email_params, user_class_mock)
            queried_users = test_obj.execute
            assert queried_users, []
        end
    end

end




=begin

class CategoriesCreateTest < Minitest::Test
    def setup
        params = { category: { name: "C1", budget: 1001 } }
        category_params = { name: "C1", budget: 1001 }

        category_params_mock = Minitest::Mock.new
        params_mock = Minitest::Mock.new

        @category_instance_mock = Minitest::Mock.new
        @category_class_mock = Minitest::Mock.new

        params_mock.expect(:require, category_params_mock, [:category])
        category_params_mock.expect(:permit, category_params, [:name, :budget, :bg_pic])
        
        @category_instance_mock.expect(:errors, [])
        @category_class_mock.expect(:create, @category_instance_mock, [ category_params ])

        @subject = Categories::Create.new(params: params_mock, category_class: @category_class_mock)
    end

    def test_returns_the_created_object
        category = @subject.create
    end
end

class CreateTest < Minitest::Test
    def setup
        @c_class_mock = Minitest::Mock.new

        category_params_mock = Minitest::Mock.new
        category_params = { name: "Bike Service & Repair", budget: 5000 } 
        category_params_mock.expect(:permit, category_params, [:name, :budget, :bg_pic])

        params_mock = Minitest::Mock.new
        params_mock.expect(:require, category_params_mock, [:category])

        # Create a mock object for category_instance
        category_instance_mock = Minitest::Mock.new

        # Stub the 'errors' method on the category_instance mock
        category_instance_mock.expect(:errors, [])

        # Expect 'create' method to be called with category_params
        @c_class_mock.expect(:create, Category.new(), [category_params])

        # Create an instance of Categories::Create and assign it to @create
        @create = Categories::Create.new(params_mock, @c_class_mock)
    end      

    def test_initialize
        assert_instance_of Categories::Create, @create
        puts "INSTANCE OF 'CATEGORIES::CREATE' IS VERIFIED!!!!"
    end

    def test_create_record
        # how to check the exact record
        assert_instance_of Category, @create.create
        puts "ALL GOOD, RECORD CREATED"
    end
end

def setup
    category_params_mock =  Minitest::Mock.new
    category_params = {name:"Bike Service & Repair",budget: 5000} 
    category_params_mock.expect :permit, category_params, [:name, :budget, :bg_pic]
    params_mock =  Minitest::Mock.new
    params = { category: {name:"Bike Service & Repair",budget: 5000} }
    params_mock.expect :require, category_params_mock, [:category]
    # Create a new Category instance
    category_instance = Category.new
    # Stub the 'errors' method on the category_instance
    category_instance.stub(:errors, nil)
    @c_class_mock = Minitest::Mock.new
    @c_class_mock.expect :create, category_instance, [ category_params ]
    # @c_class_mock.stub :errors, [], this will be called on Category, & i am creating the stub for the Categories::Create Class therefore an error
    # Category.any_instance.stub(:errors, nil), still not wroking
    @create = Categories::Create.new( params_mock, @c_class_mock )
end
=end