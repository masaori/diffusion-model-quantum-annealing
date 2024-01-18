const { Client } = require("@notionhq/client");
const { NotionToMarkdown } = require("notion-to-md");
const fs = require('fs');
// or
// import {NotionToMarkdown} from "notion-to-md";

const notion = new Client({
  auth: "secret_DKg9vhi0DqMS1UKMtwWye9sOFskxFlFxioawfuR0whH",
});

// passing notion client to the option
const n2m = new NotionToMarkdown({ notionClient: notion });

(async () => {
  const mdblocks = await n2m.pageToMarkdown("782f8fb98cf14c259f2d5e962b2cf99a");
  const mdString = n2m.toMarkdownString(mdblocks);
  console.log(mdString.parent);
  
})();