module CiteProc

	describe 'Assets' do

		before(:all) do
		  @file = Tempfile.new('asset')
			@file.write("asset content\n")
			@file.close
			
			@root = File.dirname(@file.path)
			@name = File.basename(@file.path)
			
			@extension = File.extname(@name)
		end

		after(:all) { @file.unlink }

		describe 'Style' do

			before(:all) do
				@default_root = Style.root
				@default_extension = Style.extension
				Style.root = @root
				Style.extension = @extension
			end

			after(:all) do
				Style.root = @default_root
				Style.extension = @default_extension
			end

			it 'should not be open by default' do
				Style.new.should_not be_open
			end
			
			describe '.open' do  

				it 'accepts an absolute file name' do
					Style.open(@file.path).to_s.should == "asset content\n"
				end

				it 'accepts a file name' do
					Style.open(@name).to_s.should == "asset content\n"
				end

				it 'accepts a file name without extension' do
					Style.open(@name.sub(/#{@extension}$/,'')).to_s.should == "asset content\n"
				end


				it 'accepts an io object' do
					Style.open(@file.open).to_s.should == "asset content\n"
				end

				it 'returns the given string if it looks like XML' do
					Style.open('<b>foo bar!</b>').to_s.should == '<b>foo bar!</b>'
				end
			end

      describe '.extend_name' do
        it 'adds the default extension if the file does not already end with it' do
          Style.extend_name(@name.sub(/#{@extension}$/,'')).should == @name
        end
        
        it 'does not add the default extension if the file already ends with it' do
          Style.extend_name(@name).should == @name
        end
      end
      
		end
	end
end
