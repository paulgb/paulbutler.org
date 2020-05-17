---
title: "The WebAssembly App Gap"
date: 2020-05-17
visible: true
---
To users of [Figma](figma.com/), it's no mystery why the browser-based design tool is popular. What *has* been a mystery to me is why it's so hard to point to Figma equivalents in other categories. Specifically, I mean browser-based apps that embrace modern browser tech (WebAssembly, WebGL) to compete head-to-head with desktop apps without having to compromise features for performance.

The answer, I believe, is simply that nobody's built them yet. This essay states the case for the modern browser as a platform, and explores some components that might fill the gaps in a modern stack.

## tl;dr summary

- There was a proliferation of browser-based applications circa 2005, enabled by technology.
- They tended to not be CPU or graphically intensive, due to browser limitations.
- More recently, browsers have chipped away at these limitations.
- An IT ecosystem has developed to accommodate web-based SaaS apps, facilitating browser-based software.
- Browser-based applications have lower friction and more natural collaboration.
- A stack to enable this might include:
    - Generalized CRDT data layer
    - UI component framework
    - Standardized integrations for automation tools
    - “Lambda but for WebSockets”
- The downsides are:
    - Cloud lock-in concerns
    - Non-parity with native
    - Security isn't a given

## What

The mid-2000s were a major inflection point for applications that run in the browser: Ajax went mainstream, allowing interactions without a page refresh. Browser layout engines gradually fixed bugs and cross-browser inconsistencies, making increasingly more sophisticated UIs possible. The iPhone launched with a data plan and (initially) without an app store, essentially creating the mobile web as a platform. Bandwidth continued to increase as dial-up faded into memory.

The combination of these factors meant that for the first time, in-browser applications could compete with a whole range of desktop applications, from calendars to project management to office suite equivalents.

In most cases, these applications couldn't compete feature-to-feature with their desktop counterparts (compare e.g. Google Sheets to Excel). But for large segments of users, they didn't need to. The collaborative features and low friction of use are compelling enough on their own right. Many of these applications fit Clayton Christensen's definition of [disruptive innovations](https://www.christenseninstitute.org/disruptive-innovations/): they began with a different target audience and business model from the desktop applications they ended up grabbing share from.

Still, a large class of desktop applications survived this era untouched. There were no credible, browser-based threats to image or audio editing software. You could conceivably write a book in a web browser, but the heavy lifting of typesetting it was still the realm of desktop publishing software. You might view a map in a browser and drop some points on it, but you wouldn't expect to edit complex shapefile geometries without desktop software. The same is true of video editing, medical imaging, keyframe-based animation, vector editing, 3D modeling, and computer-assisted design.

I believe we are at the beginning of a second wave of disruption, and that many of these categories have become ripe for competition from web-based counterparts. Just as technical factors in the mid-2000s enabled text-centric productivity apps to move to the web, technologies like WebAssembly, WebGL, and soon WebGPU open the door for creating CPU- and graphically-bound apps. Web Workers provide threading. Web Sockets and WebRTC provide streaming data transfer. All told, the browser has become a formidable platform for a whole class of apps that it wasn't equipped to compete with a decade ago. And while it may not be the platform we would build from scratch, it's the platform we *have*, and its ubiquity makes it impossible to ignore.

## Why

Of course, just because we *can* doesn't mean we *should*. There are several reasons why I think browser-based versions of these apps are compelling:

### Security

It might seem surprising to hear “security” and “web browsers” in the same sentence, but hear me out.

At a time when a single security breach can be an existential event for a company, IT departments are becoming even more wary about new software running on users' desktops. Last month, for example, Google and SpaceX both [banned Zoom](https://www.buzzfeednews.com/article/pranavdixit/google-bans-zoom) software from corporate machines citing security reasons.

My bet is that browsers, as application containers that are already deployed, understood by users, and integrated with corporate identity management, will become increasingly favored when bringing in outside software. Although browsers bring new security concerns into the picture (which I discuss more below), I believe that these are managable, and corporate adoption of SaaS implies that I'm not alone in thinking this.

### Collaboration

Browser-based apps tend to be more collaborative than desktop apps, in two ways.

First, they are more likely to support *real-time* collaboration, where several people can edit at once. This is not intrinsic to the browser, it just happens to be more natural when an app already has a client/server design. I tend to agree with [Alex Sharp](https://ajsharp.com/figma-for-x-is-overblown/) that this sort of collaboration is not a killer feature in every domain.

Second, they tend to be better at *asynchronous* collaboration, where multiple people view, edit, or comment on a project throughout its lifecycle. Browser-based apps have an under-appreciated advantage here: the URL. At minimum, URLs provide a string that universally identifies a project. This makes collaboration [*pass-by-reference*](https://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_reference) rather than *pass-by-value*: a top-level project link always refers to the latest version of a project, eliminating a whole category of problems related to file-based collaboration.

The true power of URLs, though, is that they are hierarchical. Browser-based apps embrace this to allow deep references into the document. In Google Sheets, you can copy a URL to a specific cell of the spreadsheet. In Figma you can link to a specific "node" of the document tree. In GitHub you can link to a *specific line* of a *specific version* of a file. Because these are just regular HTTPS URLs, they can be used anywhere regular web links can be used, like wikis, emails, task trackers, or just plain text files.

### Low-friction

Even putting aside the security implications, desktop software tends to put more of a burden on the user than browser-based software because it doesn't have to be installed. If integrated with a single-sign-on system, a new user can be inside an application with a project open within seconds of clicking a link to it for the first time.

This fact is deeply related to both types of collaboration mentioned above. The lower the barrier to opening a project in an editor, the more fluid collaboration can be.

### Hardware time-sharing

The client/server architecture of browser-based applications opens up opportunities to scale up and down the compute used by an individual throughout a session with the application. For example, when a user of 3D modeling software generates a high-quality render, the request could be fulfilled by specialized machines with high-performance GPUs instead of the regular application servers. This enables cost-effective time-sharing of hardware without the user ever having to think about it.

## How

As browsers became more capable during the mid-2000s, the ways we developed for them evolved: JavaScript frameworks emerged to patch over browser inconsistencies and dense APIs. Ruby on Rails provided a stepping stone from writing [CGI](https://en.wikipedia.org/wiki/Common_Gateway_Interface) scripts in scripting languages to writing full-fledged MVC web apps in one, sidestepping the cumbersome enterprise infrastructure of the era.

When I think about building towards the world I described above, I believe that there are a few key areas where the right common tooling could underpin the next generation of web applications, in the same way that Rails and jQuery did over a decade ago.

### Content-aware, versioned data

Desktop applications have the advantage of running local to the filesystem, so they can generally operate on the assumption that only one person is viewing and editing a file at a time — any collaboration is external to the application, and version management is the responsibility of the user.

On the web, it would be an alien experience to get an error that you can't open a file because it's already open — not only are web applications are expected to abstract away the entire concept of a file being open, we are used to seeing changes from others as they happen.

For some applications (e.g. a calendar), the data naturally conform to a flat, tabular format with row-level operations. In these cases, you don't generally need sophisticated logic to merge changes from multiple users. But when more complex applications are brought to the web, there are situations that require merging, patching, and resolving concurrent changes  into the data model. Figma has already [figured a lot of this out](https://staging.figma.com/blog/realtime-editing-of-ordered-sequences/) for their own use case.

I suspect that a lot of the work that makers of collaborative software have had to do could be generalized. One hard part, generic algorithms for merging arbitrary data structures, is already partly done: [OT](https://en.wikipedia.org/wiki/Operational_transformation) and [CRDT](https://en.wikipedia.org/wiki/Conflict-free_replicated_data_type) are well-studied areas, and there are [open-source examples](https://github.com/yjs/yjs) of each in production. I think there is potential for a “batteries included” solution for managing a data model that glues together a CRDT implementation, a persistence layer, a network layer, and version tracking with support for arbitrary transaction metadata (e.g. which user made the change). At least in theory, the same stack could provide a data backend for a variety of applications, from video editing to document authoring.

All of this assumes a mode of collaboration in which everyone is concurrently working on a single copy of the data model. It's also worth considering whether a Git-style branch/merge model might work in domains besides code. One advantage of Git is that change sets themselves become entities that can be linked to, referenced, and commented on. Imagine a telecommunications engineer updating a cellular signal coverage map by forking the map, making the change, and submitting a pull request. Any subsequent discussion and approval would happen alongside the context of the exact changes proposed, and become archived in the map's version history. This workflow could even be grafted on top of Git itself, by building content-aware diff, merge, and validation tooling for new data formats.

### UI Framework

Desktop applications tend to have rich interfaces with the flexibility for power-users to customize them — for example, arranging toolbars — to maximize the access to the tools they most frequently use. Ideally we wouldn't be implementing these controls from scratch in the browser for each application.

There are already a bunch of collections of web components, like Bootstrap, Semantic UI, and Material. These mainly provide consistent styles to the native components that are exposed by the browser (like text boxes and radio buttons), and when they provide new components it is usually to extend form inputs (dynamic drop-downs, date pickers). I can imagine a similar sort of component framework for rich web applications, complete with the interactions we expect on desktop, like being able to resize a sidebar or drag a toolbar.

### Standard interfaces for automation

The prevalence of low-code, no-code, and [Robotic Process Automation](https://en.wikipedia.org/wiki/Robotic_process_automation) tools demonstrates a desire from end-users to automate parts of their workflow. The next generation of application software seems likely to involve non-programmers implementing business logic and high-level operations workflow by stitching together different apps. Tools like Zapier and IFTTT allow a version of this today, but as far as I know, there is no standard for integrating with the dozens of platforms out there; each has its own way of integrating.

An open standard for these interfaces would go a long way to bringing about the future I imagine here. Applications would define a suite of triggers and actions, and integrations for each platform would be generated automatically. This is related to the idea of API schema standards, and in fact could be a layer on top of one. For example, actions and triggers could be represented as transformations into GraphQL mutations and subscriptions, respectively.

### Stateful Service Architecture

The common practice in web application architecture is for application servers to be stateless and to have the persistence layer store all the state, as preached by the [Twelve Factor methodology](https://12factor.net/). This has some nice properties, like simplifying server failure and load balancing. It's great for applications where mutations to the data model can be represented as small, local changes (for example, changing the description of a calendar event does not involve knowing what's on the rest of the calendar). For more sophisticated data models, it may instead make sense to keep the entire data model in memory throughout a user's session, which defies the usual preference for statelessness by requiring all access to a given document to be routed to the same server. [Figma has written](https://www.figma.com/blog/rust-in-production-at-figma/) about how they do this.

Designing and deploying this sort of system is a road less-traveled than the stateless app server approach, and there's no go-to stack for it. I would love to have an easy way to deploy a WebSocket server that starts a process corresponding to each connection for the lifetime of the connection, piped over stdio. Think [websocketd](http://websocketd.com/) meets [Lambda](https://aws.amazon.com/lambda/).

## Risks & Criticisms

Although I'm optimistic about the possibilities that browser-based applications will bring, there are a few areas that concern me.

### Security

The suite of protocols, formats, and APIs that a browser supports creates an incredibly complex and difficult-to-analyze surface area for security vulnerabilities. Fortunately, things have been improving. Modern browsers have given web apps a way to opt-in to tighter restrictions through response headers, adding additional layers of protection against CSRF and XSS. Firefox has implemented [containers](https://support.mozilla.org/en-US/kb/containers) that can isolate client-side state.

Browser extensions [especially concern me](https://twitter.com/paulgb/status/1260612879847510017). Due to the coarse permissioning system, many extensions legitimately require full permission to read and modify the page to work. If they turn out *not* to be legitimate, there's not much to stop them from spying on the user and sending information to a remote server. As a partial mitigation, enterprise policies [can be used](https://github.com/mandatoryprogrammer/ChromeGalvanizer) to disable extensions on certain sites.

### Cloud fatigue

People might, in fact *should*, feel some discomfort about storing each of their projects on cloud-based services that they don't control and may not always exist. With desktop software, at least if the vendor goes out of business you can still open your files and you don't lose your work. With cloud-based software, even if export is possible, if the service is discontinued there may be no way to use the exported data. The problem is even worse when the data model and software functionality are tightly coupled: for example, you might be able to export the parameters of a [wah-wah filter](https://en.wikipedia.org/wiki/Auto-wah) in an audio editor, but if the filter itself has a proprietary implementation, no other software will be able to apply those parameters to get the same result.

This is a problem with SaaS as a class, and I don't think it's been entirely solved. [Code escrow](https://en.wikipedia.org/wiki/Source_code_escrow) provides a partial solution, but is generally inaccessible to casual users or small shops. Another approach is a hybrid open/closed model. For example, Observable has a closed-source editor but [open-source runtime](https://github.com/observablehq/runtime), meaning you can always run the notebooks you create without relying on Observable.

### Never quite native

It's tempting to see the trend of browsers gaining capabilities of native apps and extrapolate the trend to eventual convergence, but it is unlikely that browser-based applications will ever be as capable as desktop applications. When it comes to exposing the CPU and GPU, browser APIs have to prioritize safety, so certain capabilities will always be off-limits to the browser. If vulnerabilities are found, the APIs available may even *regress* — for example, `SharedArrayBuffer`, which is necessary for sharing data between threads without copying, [continues to be disabled](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer) in FireFox as a result of the [Spectre](https://meltdownattack.com/) vulnerability.

Similarly, the UI will never converge with native on the desktop. Native menus will probably never be possible (though these are apparently passé even on native apps), and some screen real-estate will still be eaten up by the browser UI. Specialized inputs like Wacom tablets or mixing consoles may never be fully supported.

## Final Thought

What excites me most about the potential of apps in the browser is not the idea of running the same old desktop apps in a new frame, but of seeing what those applications look like when they collide with web-native features and norms. Google Docs and Figma have use cases that never would have occurred to Microsoft Word or Adobe XD users, because of the nature of the platform. Software may be soft, but human behavior is softer: we accommodate the constraints imposed by our software so well that we often don't notice all that is possible until they are removed.

*Thanks to [Taylor](https://tbaldw.in/), [Eric](https://twitter.com/ericmigi), [Michael](https://www.michaelcata.com/), and [Maks](https://maxoffsky.com/) for discussions on these ideas and comments on drafts.*