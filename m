Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5D3CCA13
	for <audit@vger.kernel.org>; Mon, 28 Sep 2026 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633457; cv=none; b=RMvzX7mcVjgRf1TcglqaBWdTVor66yO/WdAzGXhzTd03ATC7mB0bnUIG5dTcF7tz2/CCd+/oY98UZBCfgRn6JL4lBKj0yJhko6CRm5Trq8WZ3hiRb/FwCVSoCheXMoIGxPSYPR9tCk3n98t8agMIxlrSZdjvJ7z/50XysteLpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633457; c=relaxed/simple;
	bh=6neQAih1f9iptFmASXhdcpHdI16xQAaAJACc/Pd50JU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=SL8UJFHpw7ESc1pbyrvTTe/rbJdewWtz3C3XKlyOAO5bSlCbIGx5lsMW95xYgOBQU4C+NSL7WTCV00CgMdzPHQ7GXhNcBpXmahy9et+y+rEFaHQvwkyjIWQk90WuaVYInBqBbvMB2bljhuJtwF9rx4a3GwJFhigc9mij0zJk9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y5gQxW69; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y5gQxW69"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910c9ff1fso372119385a.2
        for <audit@vger.kernel.org>; Mon, 28 Sep 2026 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790633454; x=1791238254; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+Z8KJr51nfJbd82bbGhdM/nYnAQopnkkJEp1uZXbxk=;
        b=Y5gQxW69xRn42uEmXSWVw9xBx/8rz8o/r4ISLBh4MOq4UYTY8i7317Fb2eLXRxpQ1m
         /Pdk0YVXfYPXd70hnY7oskhSYt7iU2TN9fBbxGsinhKiH8k7/C/EWB02hCYhAKz5AREg
         QwTuLKuABM7Ojw69cxT6WsTzkqiY17ucqDRXDrOpEKpbxHFBQnN7iOd7zUMAXkwFNPJc
         IInrfFq72xzPr2kQ/5gX0kCOZWaWG5F9+DfGNEdl5n2EJ79Lv+MaW7w/DJobrvbkQQGe
         5ue4orCKQ9o7xevp7BgVrgt3WBXiBZOIu6IdnTwy75ys5zX59sz93BfTuchifdYxNyDk
         gC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633454; x=1791238254;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+Z8KJr51nfJbd82bbGhdM/nYnAQopnkkJEp1uZXbxk=;
        b=bNeA8K3cFxNNqj5EIU7+Sfl4EX2RbN8cfJHHtNDyG0zDcPLvDFQz+zVgmuhiMDhGgM
         z0esclTYSqkmqYX/I69rjbOJhaTV0AbEwB3WQk9L7eFEwWQBjYXktxo77pyKsg5L+jEv
         9xaRyOiuRDADimCAlf2TEirDAwgb3f3YLLRhDpTrhndzhJsMFqJdI6/Ndo8PBhKrsZLi
         ZKnkMtMczDKkUIvOkK+TB1QgH2f/5IlHI1XT+9P+o7TsxIVLQNe2kEjDHJV58S3nZGmd
         jFMGIYD/NoLuj5ldQWHVsiK4k6wFLllrlLIOeDmuFCTM/GH6M/AAxvTizJhLdalxuA8x
         Z1Jg==
X-Forwarded-Encrypted: i=1; AKwUvBz6jz/u9OKLaiC99AXzYAbQIib0acH5EjoHkxkaQuzQCSH+X1pShpG9Z40Ldh7vvOdaPJRLuQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kv4kWeGZ8U5lOisdV5Sk/ulSg9foqYaMcMMcQowD0IDe2m/9Vx
	QxUUCsILhiuOvsJPZ5FJAax1rDSURIRDcjg/7UjSQhpJhl/VRtYjoZ+idgx+VhKYhA==
X-Gm-Gg: AYBFou2jbXzy9Q0LazJYSbRb0P04x5tXRqhYz7ZaRg8GxVxDj/Ujt4FsyoX7vi05iY4
	ozmLo/e4irvx5orHdjPvlVQO0Y87H4eFlaAr7fDNSOk4ZqdNpGjFCidiBCiLGH8AHk5+VyIGUat
	w9gnDSJjvJ4lR3Dz3MJJIoEkmM9BtTn/oaBY8KxJtKVXn3boPpwxAKAh0CmECo0DULSwyr9tKbL
	TTsBeJI+D297EqpW+cKIdj8mjm23qcKJr7ijaE8O5TT2pRsZ+JBu3elqvGwqabJhoAhGwqJWi9P
	GNOgKSACHw54rzIvoWF2Z66zEfvk2dzAUQCEoh4JRps8HuXICp0ZvojCJNxZYzI0dyAo/HGMwZF
	kQAvxtb3NAWVD+4VSUv5bSGikvmr/DVFu6qHmCYnlR1gaulOOxH8Fsx/ajjShwF4H/jsm3h4ek6
	L/7sNcZUGaqaBMi9zGlPut82xbZoMWqkYsosObQK6/Bq5CqLWQaYK8cjCjxne1KBpG5afBdL7qa
	hLeT00TRyUIawlD1+Y7mE+kd1FLzl+O2XuW85CVOfX3kwDAYp/wGjF0tYREyzh9+zrpAnCkr+pG
	auxsjPy63A==
X-Received: by 2002:a05:620a:1a02:b0:939:35e5:94ba with SMTP id af79cd13be357-93c67a6fcefmr1258706085a.6.1790633454428;
        Mon, 28 Sep 2026 15:10:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c8146a237sm253039685a.36.2026.09.28.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:10:53 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:10:52 -0400
Message-ID: <600aabb0e6dbfe8f6e046a6e2cd00bcb@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260928_1559/pstg-lib:20260927_2151/pstg-pwork:20260928_1559
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, audit@vger.kernel.org
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH RFC 3/4] audit: return the collected inode entry from a  private helper
References: <20260917143948.106603-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260917143948.106603-3-cgoettsche@seltendoof.de>

On Sep 17, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Keep the __audit_inode() interface and collection behavior unchanged.
> Return the selected entry, or NULL when collection is skipped or fails,
> so audit_file() can attach descriptor-specific information reliably.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  kernel/auditsc.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 464736499c83..b14765cdd56f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2237,13 +2237,16 @@ static void audit_copy_inode(struct audit_names *name,
>  }
>  
>  /**
> - * __audit_inode - store the inode and device from a lookup
> + * audit_inode_entry - store the inode and device from a lookup
>   * @name: name being audited
>   * @dentry: dentry being audited
>   * @flags: attributes for this particular entry
> + *
> + * Return: the collected entry, or NULL if collection was skipped or failed.
>   */
> -void __audit_inode(struct filename *name, const struct dentry *dentry,
> -		   unsigned int flags)
> +static struct audit_names *audit_inode_entry(struct filename *name,
> +					     const struct dentry *dentry,
> +					     unsigned int flags)
>  {
>  	struct audit_context *context = audit_context();
>  	struct inode *inode = d_backing_inode(dentry);
> @@ -2254,7 +2257,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
>  	int i;
>  
>  	if (context->context == AUDIT_CTX_UNUSED)
> -		return;
> +		return NULL;
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(e, list, list) {
> @@ -2266,7 +2269,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
>  						f->op, f->val)
>  			    && e->rule.action == AUDIT_NEVER) {
>  				rcu_read_unlock();
> -				return;
> +				return NULL;
>  			}
>  		}
>  	}
> @@ -2320,7 +2323,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
>  	/* unable to find an entry with both a matching name and type */
>  	n = audit_alloc_name(context, AUDIT_TYPE_UNKNOWN);
>  	if (!n)
> -		return;
> +		return NULL;
>  	if (name) {
>  		n->name = name;
>  		name->refcnt++;
> @@ -2338,6 +2341,19 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
>  	}
>  	handle_path(dentry);
>  	audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
> +	return n;
> +}

Why can't we simply make __audit_inode() return an audit_names pointer?

There are only a small number of callers and they look like they could
happily ignore the return value.  You would probably need a forward
declaration of audit_names in include/linux/audit.h, but we have a number
of those at the top of the file already, one more isn't going to hurt.

> +/**
> + * __audit_inode - store the inode and device from a lookup
> + * @name: name being audited
> + * @dentry: dentry being audited
> + * @flags: attributes for this particular entry
> + */
> +void __audit_inode(struct filename *name, const struct dentry *dentry,
> +		   unsigned int flags)
> +{
> +	audit_inode_entry(name, dentry, flags);
>  }
>  
>  void __audit_file(const struct file *file)
> -- 
> 2.55.0

--
paul-moore.com
