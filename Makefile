.PHONY: website pages blog deploy dryrun createIndex clean files newpost

website: deploy

dryrun: createIndex blog
	./scripts/deploy.sh live

deploy: createIndex blog
	./scripts/deploy.sh live go

pages: files imgs styles
	./scripts/cvt_pages.sh

blog: files imgs styles
	./scripts/cvt_post_list.sh

styles:
	cp -r css ./src/css

imgs:
	cp -r img ./src/img

files: rawMarkdown
	cp -r files ./src/files

rawMarkdown:
	./scripts/copy_raw_markdown.sh

createIndex: pages
	rm -f src/index.html
	./scripts/create_index.sh home

newpost:
	./scripts/newpost.sh

clean:
	rm -rf src/*
