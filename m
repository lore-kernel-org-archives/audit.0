Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB223F3282
	for <audit@vger.kernel.org>; Thu, 13 Aug 2026 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646299; cv=none; b=V3vQu8mT9vClzyGRHG5XjE9AJ5ryVdxE1NfD2PvOSTwR1KQGW6x8bqpLEU6QyGcHpgezB8C0oviCJkW1LItFFdg7mxK80OKfR68yhoLXnEU5STI+3uMU8MHrQ0TwplNNB0maRHQfNf1PV+eQXcSoNrorULFxdDEnU4+/FtpxITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646299; c=relaxed/simple;
	bh=ojp2NQRF9AcENpZGFFPB1P+sQAUMLLM/0PDtnYLV2HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tKsHMW/rF8PoVFftq5E4zZq5rSkv/PLxVLe3k2dg4eOWLvIyQAwb8kIEhVZ8yxopBBYh5aK34SfMav+MLlh/cDqBNe+VmyHYEee+lpptqOFNWwmpLoi9sZQv7uGwoT10AVizK+PiEXSHcxGfuKO0MO2bouA272Ogeg/EB2c4Wwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOUK09+W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOUK09+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786646296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NXpmtye9fW5Bk/p7JBHiAivRkcTSnn1rf1VjuyhKSs=;
	b=XOUK09+W3N4bsyNSE06UbQlBxMm1k3JLsgbSV1VtKLDFenU3aSQPecCINK1WEhpXuLuJsz
	s++CH04gX++z79OvyjQY2lGXiA6y88lXbTPhVGa0OuTnnIuy21a/nRUtwPikIHTcwBdazl
	jOCL1XXsiAH+zX/63BopcgQJhw3thEM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-qU2SfC8ONN6vTQyb7JxZqw-1; Thu,
 13 Aug 2026 14:38:13 -0400
X-MC-Unique: qU2SfC8ONN6vTQyb7JxZqw-1
X-Mimecast-MFC-AGG-ID: qU2SfC8ONN6vTQyb7JxZqw_1786646292
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E09C818002C8;
	Thu, 13 Aug 2026 18:38:11 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.74.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E6A0195608A;
	Thu, 13 Aug 2026 18:38:09 +0000 (UTC)
Date: Thu, 13 Aug 2026 14:38:07 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: audit@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: avoid dropping live tree ref on fsnotify rule
 autoremove
Message-ID: <an4PD+pSgk/kyU/R@madcap2.tricolour.ca>
References: <20260811220128.275783-1-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260811220128.275783-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: CifIjGjXdjobinP1AJt-Rrl6lndqMaaI86mqwRA6534_1786646292
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2026-08-11 22:01, Jérémy Jean wrote:
> audit_del_rule() is used for both netlink deletion templates and internal
> fsnotify autoremove.  The former passes a parsed template which owns a
> temporary tree reference; the latter passes the installed entry itself.
> 
> The unconditional audit_put_tree() at the end of audit_del_rule() assumes
> the template case.  For mixed AUDIT_DIR plus AUDIT_EXE rules, an fsnotify
> autoremove event therefore drops the installed rule's live tree reference.
> Repeating this across rules sharing the same tree can free the tree while
> another rule still references it, and a later autoremove dereferences the
> freed pathname while comparing rules.
> 
> Move the temporary-tree put to audit_rule_change(), the caller that owns
> deletion templates.  Keep it in the AUDIT_DEL_RULE cleanup so both
> successful deletion and -ENOENT still release the parser-owned tree.
> 
> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Thanks for finding this!

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  kernel/auditfilter.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 7f791afe5791..666c2091b9e4 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1023,7 +1023,6 @@ static inline int audit_add_rule(struct audit_entry *entry)
>  int audit_del_rule(struct audit_entry *entry)
>  {
>  	struct audit_entry  *e;
> -	struct audit_tree *tree = entry->rule.tree;
>  	struct list_head *list;
>  	int ret = 0;
>  #ifdef CONFIG_AUDITSYSCALL
> @@ -1071,9 +1070,6 @@ int audit_del_rule(struct audit_entry *entry)
>  out:
>  	mutex_unlock(&audit_filter_mutex);
>  
> -	if (tree)
> -		audit_put_tree(tree);	/* that's the temporary one */
> -
>  	return ret;
>  }
>  
> @@ -1158,6 +1154,8 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
>  	}
>  
>  	if (err || type == AUDIT_DEL_RULE) {
> +		if (type == AUDIT_DEL_RULE && entry->rule.tree)
> +			audit_put_tree(entry->rule.tree); /* that's the template one */
>  		if (entry->rule.exe)
>  			audit_remove_mark(entry->rule.exe);
>  		audit_free_rule(entry);
> -- 
> 2.47.3
> 
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

