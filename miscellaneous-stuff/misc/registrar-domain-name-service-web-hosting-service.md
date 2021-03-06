
# Table of Contents

1.  [Terminology: Registrar, Domain Name Service, Web Hosting Service](#terminology-registrar-domain-name-service-web-hosting-service)
    1.  [Three Roles of Hosting](#three-roles-of-hosting)
        1.  [In a Nutshell](#in-a-nutshell)
        2.  [The Web Site Host](#the-web-site-host)
        3.  [The Registrar](#the-registrar)
        4.  [The Domain Name Service](#the-domain-name-service)
    2.  [Permissions, Roles](#permissions-roles)
        1.  [Domain Name Ownership](#domain-name-ownership)
        2.  [Web Site Content Ownership](#web-site-content-ownership)
        3.  [Domain Name Service Resolution Ownership](#domain-name-service-resolution-ownership)
    3.  [Conclusion](#conclusion)


<a id="terminology-registrar-domain-name-service-web-hosting-service"></a>

# Terminology: Registrar, Domain Name Service, Web Hosting Service

-   published date: 2015-10-16 04:20
-   keywords: ["classes", "definitions", "dns", "domain-name-service", "front-end-series", "gdi", "glossary", "providers", "publishing", "registrar", "web-development", "web-hosting", "web-hosting-service", "web-publishing"]
-   source:

Recently, in a [class](http://www.meetup.com/Girl-Develop-It-Minneapolis/events/224752393/) I was assisting at, a question came up that involved understanding who has permissions to change what shows up for a given domain name.

---

**Contents:**

-   contents {:toc}

---


<a id="three-roles-of-hosting"></a>

## Three Roles of Hosting

There are three major roles involved in getting your web site content displayed to a user:

-   The Web Site Host, who sells you your **web hosting package**.
-   The Registrar, who sells you your **domain name**.
-   The Domain Name Service, aka **DNS**, who connects your **domain name** with your **web site**.

All three of these roles might be fulfilled by the same company; a company such as [Gandi.net](http://gandi.net) provides all three of these services. Sometimes, they are fulfilled by different companies. Sometimes, you may be providing some of these parts if you're a hosting reseller.


<a id="in-a-nutshell"></a>

### In a Nutshell

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


</table>


<a id="the-web-site-host"></a>

### The Web Site Host

The Web Site Host, aka "web hosting service", aka "host", is who you rent space from to hold the files of your web site. The host provides you with an **IP Address**, a sequence of 4 numbers, e.g. 174.53.192.61. (This is IP version 4, IPv4. There is also IP version 6, IPv6, where the numbers look a lot different, like so: 2601:443:1:1605:e4de:d6dd:4943:326d ) That address is precisely where the world will find your website. As no one wants to remember a set of numbers like that, we have domain names.

When you rent space, you provide the actual content (html, images, scripts, css, etc.) that will be displayed to the user, and the host provides the web server that will display that information when asked for at that IP address. You are given complete control over the files that will be displayed. (If you aren't, change web hosts.)


<a id="the-registrar"></a>

### The Registrar

The Registrar is who you buy your domain name from. Domain names aren't so much "bought" as "rented", as you can only remain in control of the name as long as you pay an annual fee for that name.

You are given control over the domain name to be able to say what DNS will be used to **resolve** your name. "Resolve" is the term that says "My domain name points to this IP address", and is a rather complicated, messy process that we're all glad someone else maintains.


<a id="the-domain-name-service"></a>

### The Domain Name Service

The DNS provides the glue between your domain name and your web site IP address. The DNS lets you say how your domain will resolve to that IP address, and provides the servers that perform that resolution. You are given control (possibly limited) over how that resolution happens. As the actual records that perform the mapping can seem rather arcane, most DNS providers give you an easier way to manage those entries.

In most cases, you'll want an **A** record that directly maps a domain name to an IP address. Sometimes you will want a **CNAME** record that maps one domain name to another. [Wikipedia](https://www.wikipedia.org/) has a complete [list of DNS record types](https://en.wikipedia.org/wiki/List_of_DNS_record_types)

---


<a id="permissions-roles"></a>

## Permissions, Roles

The hypothetical scenario from the [class](http://www.meetup.com/Girl-Develop-It-Minneapolis/events/224752393/), "If I'm hosting my boyfriend's website, and I want to change change where it's pointing to, could I do that?" comes down to this: who owns what?


<a id="domain-name-ownership"></a>

### Domain Name Ownership

The person who buys a domain name from a registrar has the ability to change where that domain is resolved. If your boyfriend bought, then he can decide. If you bought it on his behalf, you can change it. If you have access to his account at the registrar, you can change it, but he can change it back.


<a id="web-site-content-ownership"></a>

### Web Site Content Ownership

Some of you have taken advantage of the web hosting reseller package, in which case, you can be a web hosting provider yourself. As someone who sells such a service, you can control what is on your customer's site, but just like your upstream provider, you wouldn't really want them to do that. But again, you have the power to change things.


<a id="domain-name-service-resolution-ownership"></a>

### Domain Name Service Resolution Ownership

This can be the tricky part, because, again in the case where you're doing the hosting reseller thing, you will likely also have the control over the DNS record, and could point your boyfriend's domain name at a different IP address (**A** record), or another domain name (**CNAME** record).

---


<a id="conclusion"></a>

## Conclusion

Ultimately, like most everywhere else on the net, if you have the credentials to change something, you can. It isn't always ethical to do so, of course.

