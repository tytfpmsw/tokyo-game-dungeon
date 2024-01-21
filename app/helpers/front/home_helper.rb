module Front::HomeHelper
    def page_items
        [
            {
                name: "Home",
                path: root_path
            },
            {
                name: "About",
                path: about_path
            },
            {
                name: "Contact",
                path: contact_path
            },
            {
                name: "Blog",
                path: blog_path
            },
            {
                name: "Portfolio",
                path: portfolios_path
            }
        ]
    end
end
