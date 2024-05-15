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