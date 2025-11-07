// get the ninja-keys element
const ninja = document.querySelector('ninja-keys');

// add the home and posts menu items
ninja.data = [{
    id: "nav-about",
    title: "about",
    section: "Navigation",
    handler: () => {
      window.location.href = "/";
    },
  },{id: "nav-blog",
          title: "blog",
          description: "",
          section: "Navigation",
          handler: () => {
            window.location.href = "/blog/";
          },
        },{id: "nav-projects",
          title: "projects",
          description: "collecting pebbles",
          section: "Navigation",
          handler: () => {
            window.location.href = "/projects/";
          },
        },{id: "nav-publications",
          title: "publications",
          description: "tiny nodes in the giant network of knowledge",
          section: "Navigation",
          handler: () => {
            window.location.href = "/publications/";
          },
        },{id: "nav-teaching",
          title: "teaching",
          description: "what i wanted to learn",
          section: "Navigation",
          handler: () => {
            window.location.href = "/teaching/";
          },
        },{id: "nav-repositories",
          title: "repositories",
          description: "automated doodles",
          section: "Navigation",
          handler: () => {
            window.location.href = "/repositories/";
          },
        },{id: "nav-cv",
          title: "cv",
          description: "Gaussian process",
          section: "Navigation",
          handler: () => {
            window.location.href = "/cv/";
          },
        },{id: "post-surfing-lea-️",
      
        title: "Surfing LEA 🏄‍♀️👧",
      
      description: "Surface-based analysis that can work very various surfaces",
      section: "Posts",
      handler: () => {
        
          window.location.href = "/blog/2025/surf/";
        
      },
    },{id: "post-teap2025-ended",
      
        title: "TeaP2025 ended",
      
      description: "Helping organizing a conference",
      section: "Posts",
      handler: () => {
        
          window.location.href = "/blog/2025/teap/";
        
      },
    },{id: "post-chatgpt4o-for-bash-one-liners",
      
        title: "ChatGPT4o for BASH one-liners",
      
      description: "It&#39;s a magic!😳",
      section: "Posts",
      handler: () => {
        
          window.location.href = "/blog/2024/oneliner/";
        
      },
    },{id: "post-lea",
      
        title: "LEA👧",
      
      description: "Linearized Encoding Analysis MATLAB package",
      section: "Posts",
      handler: () => {
        
          window.location.href = "/blog/2024/lea/";
        
      },
    },{id: "post-how-do-i-edit-a-file-in-a-terminal",
      
        title: "How do I edit a file in a Terminal? 🤷",
      
      description: "&#39;You cannot make a spoon that is better than a spoon&#39; -Umbert Eco",
      section: "Posts",
      handler: () => {
        
          window.location.href = "/blog/2024/clied/";
        
      },
    },{id: "post-temporal-orders",
      
        title: "Temporal orders",
      
      description: "Twisted Granger causality",
      section: "Posts",
      handler: () => {
        
          window.location.href = "/blog/2024/orders/";
        
      },
    },{id: "post-time-deconvolution",
      
        title: "Time deconvolution",
      
      description: "Is it a sample thing?",
      section: "Posts",
      handler: () => {
        
          window.location.href = "/blog/2024/deconv/";
        
      },
    },{id: "post-projection-matrix",
      
        title: "Projection matrix",
      
      description: "A little bit of mumbling",
      section: "Posts",
      handler: () => {
        
          window.location.href = "/blog/2024/regproj/";
        
      },
    },{id: "news-new-homepage-house-hosted-by-github-pages",
          title: 'New homepage:house: hosted by GitHub Pages!',
          description: "",
          section: "News",},{id: "news-new-paper-scroll-kim-et-al-2024-linguistic-modulation-of-the-neural-encoding-of-phonemes-cerebral-cortex",
          title: 'New paper:scroll:: Kim et al. 2024. Linguistic modulation of the neural encoding of...',
          description: "",
          section: "News",},{id: "news-i-am-visiting-south-korea-for-the-annual-meeting-of-organization-for-human-brain-mapping-in-seoul-23-27-june-2024-update-poster",
          title: 'I am visiting South Korea for The Annual Meeting of Organization for Human...',
          description: "",
          section: "News",},{id: "news-i-am-attending-the-neuroscience-and-music-viii-in-helsinki-13-16-june-2024-see-you-all-music-brain-lovers-musical-score",
          title: 'I am attending The Neuroscience and Music-VIII in Helsinki, 13-16 June 2024. See...',
          description: "",
          section: "News",},{id: "news-i-will-be-giving-a-talk-about-neural-encoding-of-musical-emotions-at-a-symposium-at-the-department-of-music-therapy-ewha-womans-university-in-seoul-on-24-june-2024-update-slides",
          title: 'I will be giving a talk about “Neural Encoding of Musical Emotions” at...',
          description: "",
          section: "News",},{id: "news-i-will-teach-a-3-hour-course-titled-linearized-encoding-modeling-a-predictive-analysis-methodology-for-music-perception-at-the-ksmpc-korean-society-for-music-perception-and-cognition-summer-school-2024-only-korean-via-zoom-on-7-september-2024-update-github-teaching",
          title: 'I will teach a 3-hour course titled “Linearized Encoding Modeling: a Predictive Analysis...',
          description: "",
          section: "News",},{id: "news-i-will-co-teach-a-seminar-music-and-the-brain-with-dr-daniela-sammler-at-goethe-university-frankfurt-i-will-be-in-charge-of-teaching-the-half-of-4-topics-perception-24-10-07-11-2024-and-emotion-16-30-1-2025",
          title: 'I will co-teach a seminar “Music and the Brain” with Dr. Daniela Sammler...',
          description: "",
          section: "News",},{id: "news-i-will-teach-a-2-hour-course-on-neuroscience-of-music-and-emotion-as-a-part-of-cognition-academies-for-the-max-planck-school-of-cognition-mpscog-phd-program-at-harnack-haus-berlin-on-5-december-2024-update-teaching",
          title: 'I will teach a 2-hour course on “Neuroscience of Music and Emotion” as...',
          description: "",
          section: "News",},{id: "news-i-have-joined-the-editorial-board-of-music-perception-an-interdisciplinary-journal-as-of-1-novemeber-2024-as-a-consulting-editor-much-looking-forward-to-contributing-to-the-journal",
          title: 'I have joined the Editorial Board of Music Perception: an interdisciplinary journal as...',
          description: "",
          section: "News",},{id: "news-i-and-my-colleagues-at-the-mpiea-invite-you-to-a-hybrid-event-open-science-workshop-on-26-november-2024-14-00-17-00-cet-where-we-discuss-practical-ideas-and-measures-to-promote-the-fairness-reproducibility-and-transparency-of-scientific-research",
          title: 'I and my colleagues at the MPIEA invite you to a hybrid event,...',
          description: "",
          section: "News",},{id: "news-teap2025-german-experimental-psychologists",
          title: 'TeaP2025-German Experimental Psychologists',
          description: "",
          section: "News",handler: () => {
              window.location.href = "/news/2025-01-05_teap/";
            },},{id: "news-plos-one-academic-editor",
          title: 'PLOS ONE Academic Editor',
          description: "",
          section: "News",handler: () => {
              window.location.href = "/news/2025-01-06_plos/";
            },},{id: "news-peer-community-in-neuroscience-pci-neuro-recommender",
          title: 'Peer Community In Neuroscience (PCI-neuro) Recommender',
          description: "",
          section: "News",handler: () => {
              window.location.href = "/news/2025-01-27_pci-neuro/";
            },},{id: "news-everything-is-red-queen-s-race-docker-compose-crumbles-jekyll-breaks-so-i-have-recreated-my-homepage-from-scratch-by-importing-a-new-template-v0-14-3-now-we-have-the-search-function-cmd-cnt-k",
          title: 'Everything is Red Queen’s race. Docker-compose crumbles. Jekyll breaks. So, I have recreated...',
          description: "",
          section: "News",},{id: "news-i-m-so-happy-to-share-my-new-preprint-today-reverse-double-dipping-when-data-dips-you-twice-stimulus-driven-information-leakage-in-naturalistic-neuroimaging-biorxiv",
          title: 'I’m so happy to share my new preprint today: “Reverse Double-Dipping: When Data...',
          description: "",
          section: "News",},{id: "news-as-of-23-may-2025-i-have-joined-the-peer-community-in-psychology-pci-neuro-as-a-recommender",
          title: 'As of 23 May 2025, I have joined the Peer Community In Psychology (PCI-neuro) as...',
          description: "",
          section: "News",},{id: "news-i-am-attending-icmpc18-in-são-paulo-brazil-from-july-21-to-25-2025-i-will-present-1-a-workshop-on-lea-july-21-16-45-18-15-bd-45-rm-501-2-a-spoken-presentation-on-manymusic-stimuli-july-25-se44-emotion-rm-502-see-you-in-brazil",
          title: 'I am attending ICMPC18 in São Paulo, Brazil from July 21 to 25,...',
          description: "",
          section: "News",},{id: "news-do-you-live-in-frankfurt-am-main-area-and-love-music-️",
          title: 'Do you live in Frankfurt am Main area and love music❤️ 🎶?',
          description: "",
          section: "News",handler: () => {
              window.location.href = "/news/2025-07-17_musafx-part/";
            },},{id: "news-manymusic-stimuli-sets-are-published-see-our-new-paper",
          title: 'ManyMusic stimuli sets are published! See our new paper!',
          description: "",
          section: "News",},{id: "projects-absolute-pitch",
          title: 'Absolute pitch',
          description: "Is it a musical gift or a musical curse? Updated: 2024-09-22",
          section: "Projects",handler: () => {
              window.location.href = "/projects/proj_absolute-pitch/";
            },},{id: "projects-encoding-modeling",
          title: 'Encoding modeling',
          description: "Understanding neural representationUpdated: 2024-09-08",
          section: "Projects",handler: () => {
              window.location.href = "/projects/proj_encoding-modeling/";
            },},{id: "projects-musical-emotion",
          title: 'Musical emotion',
          description: "How do sounds evoke emotion?Updated: 2024-09-23",
          section: "Projects",handler: () => {
              window.location.href = "/projects/proj_musical-emotion/";
            },},{id: "projects-myelination-imaging",
          title: 'Myelination imaging',
          description: "Quantification of myelinationUpdated: 2024-09-09",
          section: "Projects",handler: () => {
              window.location.href = "/projects/proj_myelin-imaging/";
            },},{id: "teaching-seminar-empirical-methods-for-music-research",
          title: 'Seminar: Empirical Methods for Music Research🎼🔬',
          description: "2022 Winter - 2024 Summer",
          section: "Teaching",handler: () => {
              window.location.href = "/teaching/teach_hfmk_methods/";
            },},{id: "teaching-tutorials-how-to-use-computers",
          title: 'Tutorials: How to use computers💻',
          description: "2024, Max Planck Institute for Empirical Aesthetics",
          section: "Teaching",handler: () => {
              window.location.href = "/teaching/teach_mpi_computers/";
            },},{id: "teaching-tutorials-fmri-data-preprocessing",
          title: 'Tutorials: fMRI Data Preprocessing🍱',
          description: "2015, 2017, Method Club, Max Planck Institute for Human Cognitive and Brain Sciences, Leipzig, Germany",
          section: "Teaching",handler: () => {
              window.location.href = "/teaching/teach_mpi_methodclub/";
            },},{id: "teaching-seminar-music-and-the-brain",
          title: 'Seminar: Music and the Brain🎶🧠',
          description: "2024 Winter",
          section: "Teaching",handler: () => {
              window.location.href = "/teaching/teach_ug_musbrain/";
            },},{id: "teaching-tutorial-linearized-encoding-analysis",
          title: 'Tutorial: Linearized Encoding Analysis👧',
          description: "2024-Sep-07, Korean Society for Music Perception and Cognition [KSMPC] Summer School, South Korea",
          section: "Teaching",handler: () => {
              window.location.href = "/teaching/teach_w_ksmpc24/";
            },},{id: "teaching-workshop-music-brain-and-emotions-an-engaging-self-experiment",
          title: 'Workshop: Music, Brain, and Emotions: An Engaging Self-Experiment🥲',
          description: "2024-Dec-05, Max Planck School of Cognition--Cognition Academies",
          section: "Teaching",handler: () => {
              window.location.href = "/teaching/teach_w_mpsc24/";
            },},{
        id: 'social-bluesky',
        title: 'Bluesky',
        section: 'Socials',
        handler: () => {
          window.open("https://bsky.app/profile/seunggookim.bsky.social", "_blank");
        },
      },{
        id: 'social-email',
        title: 'email',
        section: 'Socials',
        handler: () => {
          window.open("mailto:%64%72.%73%65%75%6E%67%67%6F%6F.%6B%69%6D@%67%6D%61%69%6C.%63%6F%6D", "_blank");
        },
      },{
        id: 'social-orcid',
        title: 'ORCID',
        section: 'Socials',
        handler: () => {
          window.open("https://orcid.org/0000-0003-2551-3059", "_blank");
        },
      },{
        id: 'social-rss',
        title: 'RSS Feed',
        section: 'Socials',
        handler: () => {
          window.open("/feed.xml", "_blank");
        },
      },{
        id: 'social-scholar',
        title: 'Google Scholar',
        section: 'Socials',
        handler: () => {
          window.open("https://scholar.google.com/citations?user=-M8Z3agAAAAJ", "_blank");
        },
      },{
        id: 'social-work',
        title: 'Work',
        section: 'Socials',
        handler: () => {
          window.open("https://www.aesthetics.mpg.de/en/the-institute/people/seung-goo-kim.html", "_blank");
        },
      },{
      id: 'light-theme',
      title: 'Change theme to light',
      description: 'Change the theme of the site to Light',
      section: 'Theme',
      handler: () => {
        setThemeSetting("light");
      },
    },
    {
      id: 'dark-theme',
      title: 'Change theme to dark',
      description: 'Change the theme of the site to Dark',
      section: 'Theme',
      handler: () => {
        setThemeSetting("dark");
      },
    },
    {
      id: 'system-theme',
      title: 'Use system default theme',
      description: 'Change the theme of the site to System Default',
      section: 'Theme',
      handler: () => {
        setThemeSetting("system");
      },
    },];
