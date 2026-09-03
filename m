Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A94E80B4
	for <audit@vger.kernel.org>; Thu,  3 Sep 2026 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453458; cv=none; b=iNby2YqaOBdZjPwu9r67ksB469J4qrfkSYeG1e8zZQD+GAek8OWOHydgD+hRYSpR7UYgLEOkXe4I+25/tFcMsomD1W9LJQsfrE0LqZ21Yt2MS2nFkMjmvrmRY+FnF0amLApWYWd7B4iU1eof6q9pzUW6S1erLAAftsD+Xem5TDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453458; c=relaxed/simple;
	bh=DHU0rPfE8pNw4y8f4EIiMA8AyjtO5KJ1FJuAuI0+mmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BS5y+NKVMKZFIOdUK482iLixQVfUZV3mDRsj9MHSBljQJgv7GRfzcExiFZ6IOMV4l9hSk1MaD4hfMXJQQt4F8Auh1b4DEe/K73RVwgqe4ta5K/x9s6j+llSGifOiLbM/GiYuyT0vMLClKFH5hcuCmTvUeqnA76bSkZ3s3AOtF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcbRr86S; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcbRr86S"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso2261380b3a.1
        for <audit@vger.kernel.org>; Thu, 03 Sep 2026 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788453456; x=1789058256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lUZB+Y/RFFX7U5B1GssgETxfMaouezB0VLydJYjs6v0=;
        b=NcbRr86SwjtDYcr0LYOS/0WeBTIbyh048e+GFTE6zRhR1pHyVAFZ6yys9EXJT2RXmi
         lHtzWGeXE4MCLnQzc0bnrrediUAEuhuQBtT0pwzjjG8mdYsvrXt5W4+oarXuTavPO3a9
         z0NYNUMP9LXiE7AaOI7BHdRnWkbGCozQr3arFPaJXJ0tDnBnS2Rs9cefrZNkPy9YELhR
         cvuGTtZxQm/0u9hYsy+NtY7IXp+cfYESm7MgwpoNA/tZRmE4Y3H3Jd7lne5T1h3UwRos
         m7xNiBvIVqvsvupia/HLFIXGONcqN47YK8C1/g+YYvNl7hKmvQLoMQZD8EuP671+iSpL
         iT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453456; x=1789058256;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUZB+Y/RFFX7U5B1GssgETxfMaouezB0VLydJYjs6v0=;
        b=Rs521ZQqhIZVuKVkBrmDyQZyIxo3SBLLVwnPwHlvm6xcL3JxoorolwW8MNcDF42fpx
         kLWwvCYOPL2Mq3VTY6HkMLFT5UV8ToCdzCS2oS80LmJGtZgYkR6wbyzwLE5pLNxijPzu
         U+TzPkxX4sGkDqoUxh31N87MGw4IC6emTR7qiduUGzwQMXDDJ/5Sr2WNWm9PZiuNOHTo
         D3/hszmYM9j+SA1f782e0r2qtS1xylVIvifDIs3/+aFtFDnw6kUpWzOPGUS2Nk5pBWeW
         d8vXygO48H47IkOV5NqwewQRmj1mimRrAk0py8xQlSsRrY8SzirzRzf7Qs0G4p35kyjo
         Vqgg==
X-Forwarded-Encrypted: i=1; AKwUvBzaXcvw2g1HDatpNU8Nal8rmOCSYGYtx5/l3VC4YkJZUbTW/bVgFt/5DBXcJsdUyeUMI3ST/w==@vger.kernel.org
X-Gm-Message-State: AFuF++ncXjiloN64CxuhoqF3V+gi/B81rEbhspbrJ3T8l1+/C40znL37
	+p6XGf0/w7jYyuDvWGvu3UHxTkESmkQrHhtG1F1sAAHnKdR+qF2SuUD+
X-Gm-Gg: AYBFou2H+qnuVvbu1qX/RgudxfP1Mvia92b8iTuesbhLN5BfdFAnHPrvR46Mad7rH83
	KCqxRcsCWL2gcHNV25drfuSWfuWRDlIvgXOWJO264Cq3UZaPWdRUt0LSrDRnfrbOp7oB31G9ejf
	crOrEFgY06d9q+N6ypuN53Gv4QUjcalSwDoGqpVuX6d2Oinbvw18JiLBg4qDhirk9sV/7/hUec5
	hNSTBw9lceQ/SoMSeJUeZ5Iu7eci9p5SNccQzFJF9pb4TQHb97sjiVzj0/4QND6sxGrVCVQz39N
	laVV6rsoX3+NV1AvRUBbx/KapLVRrm/J20+m6XuN6DplYwW4Q4C4Kymh1+O4mRcmg2PODX3GPCe
	T07O/N6qDwyFFNPpJsje6A6WSxaNmydTWeRL9CkkrPu5Ft7dABXHksX0ETySZFjzvDtb2Kp5ZSI
	/ux7xL/uzgsgrIEJTi+VH24HsFKFB8LpwLh4sfIpMAt6QBs690CIVIoGCzqUINAUxHWnuHtkUE4
	D52n8woU1ZnNAsqOS/yZ6WnYQdT0vTDiWPTINJXLw==
X-Received: by 2002:a05:6a00:3d48:b0:84e:4d6:78fe with SMTP id d2e1a72fcca58-861679a5642mr313171b3a.3.1788453456351;
        Thu, 03 Sep 2026 09:37:36 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615273a099sm174320b3a.22.2026.09.03.09.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:37:35 -0700 (PDT)
Date: Thu, 3 Sep 2026 09:37:33 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Shuah Khan <shuah@kernel.org>, Eric Paris <eparis@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Amy Griffis <amy.griffis@hp.com>,
	Frank Hofmann <hofmann@deshaw.com>,
	Noah Orlando <orlandon@deshaw.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 3/3] audit: Skip exit filtering for syscalls without rules
Message-ID: <apmiTQqF8lJ50sNC@skinsburskii>
References: <20260806-audit-v1-3-ddd0d94ff0b6@gmail.com>
 <23b54475e31ed2c5248650d5aca830f5@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b54475e31ed2c5248650d5aca830f5@paul-moore.com>

On Tue, Sep 01, 2026 at 05:35:16PM -0400, Paul Moore wrote:
> On Aug  6, 2026 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > 
> > Audit walks every exit filter rule for each audited syscall, even when no
> > rule contains the current syscall number. Policies with many unrelated
> > rules therefore add linear overhead to otherwise uninteresting syscalls.
> > 
> > Maintain a reference count for each syscall bit present in exit filter
> > rules and derive an aggregate interest mask. Update the mask through the
> > centralized rule lifecycle helpers, which cover explicit and automatic
> > rule removal. Use the mask as a lockless rejection test before entering
> > the exit filter RCU traversal.
> > 
> > The mask is architecture-independent. Syscall number overlap between
> > architectures can cause an unnecessary scan but cannot suppress a match.
> > 
> > The aggregate bit must be set before list_add_rcu() publishes a new rule.
> > Otherwise, a reader could observe the rule after publication while the
> > aggregate mask still rejects its syscall. Move audit_rule_account()
> > before the list insertion to provide this ordering. Rule removal already
> > uses the inverse safe ordering: it unlinks the rule before clearing the
> > aggregate bit, so a concurrent reader can only perform an unnecessary
> > scan, not miss a rule.
> > 
> > To measure the effect, install increasing numbers of distinct statx rules
> > in a disposable VM and benchmark the unrelated getpid syscall after each
> > set is installed:
> > 
> >   for nr_rules in 1 32 128 256; do
> >           auditctl -D
> >           for uid in $(seq 1 $nr_rules); do
> >                   auditctl -a always,exit -F arch=b64 -S statx \
> >                            -F uid=$uid
> >           done
> >           audit_bench
> >   done
> > 
> > Without this change, the same unpinned VM produced:
> > 
> >   1 rule:
> >     median=55 ns/op
> >   32 rules:
> >     median=71 ns/op
> >   128 rules:
> >     median=428 ns/op
> >   256 rules:
> >     median=791 ns/op
> > 
> > With this change, it produced:
> > 
> >   1 rule:
> >     median=55 ns/op
> >   32 rules:
> >     median=55 ns/op
> >   128 rules:
> >     median=55 ns/op
> >   256 rules:
> >     median=55 ns/op
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> > ---
> >  kernel/audit.h       |  2 ++
> >  kernel/auditfilter.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  kernel/auditsc.c     | 13 ++++++++++++
> >  3 files changed, 70 insertions(+), 1 deletion(-)
> 
> We've had similar proposals in the past, and I'll say the same thing I've
> said in the past: I'm not certain that our answer to filter performance is
> to add additional complexity and filtering.  It may turn out that an
> approach like this is the only option, but I'd really like to see more
> effort put into improving a singular filter mechanism (either the current
> approach or a replacement design) before we start layering on additional
> complexity.
> 

I see. Indeed, the mask is effectively another filter in front of the
existing rule list.

One alternative would be to replace the global runtime exit-rule
traversal with an array of RCU-protected, ordered candidate lists,
conceptually:

  candidates[__NR_getpid] = {
          rules whose syscall mask includes __NR_getpid
  }

Filtering would then look roughly like:

  rcu_read_lock();
  list_for_each_entry_rcu(candidate, &candidates[syscall], list) {
          if (audit_filter_rules(...))
                  break;
  }
  rcu_read_unlock();

A canonical registry would still keep each rule once for rule management
and listing, while the syscall path would use only the candidate index.
This would make the index the runtime filtering mechanism, rather than
another filter layered in front of the existing traversal.

What do you think about this approach?

Thanks,
Stanislav

> --
> paul-moore.com
