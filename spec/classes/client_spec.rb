# frozen_string_literal: true

require 'spec_helper'

describe 'mongodb::client' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }

        if facts[:os]['release']['major'] =~ %r{(10)}
          it { is_expected.to create_package('mongodb_client').with_ensure('4.4.8') }
        else
          it { is_expected.to create_package('mongodb_client').with_ensure('present') }
        end
      end

      context 'with manage_package' do
        let(:pre_condition) do
          "class { 'mongodb::globals': manage_package => true }"
        end

        it { is_expected.to compile.with_all_deps }

        if facts[:os]['release']['major'] =~ %r{(10)}
          it { is_expected.to create_package('mongodb_client').with_ensure('4.4.8').with_name('mongodb-org-shell').with_tag('mongodb_package') }
        else
          it { is_expected.to create_package('mongodb_client').with_ensure('present').with_name('mongodb-org-shell').with_tag('mongodb_package') }
        end
      end
    end
  end
end
