Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7C37F737
	for <audit@vger.kernel.org>; Tue, 25 Aug 2026 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787622986; cv=pass; b=F3VMV4Pnb8B8fA7SGEzhK/7vlN6mj4BQiAfyCOhop689eMw/LIfgEd/BSI4Cr+PLihp6Uy5Sd+tGMowwpkX+kfloRLzi3Y8rCj7PPVLO9xIoz9dG80mkTYEA9yE+dKN7t+HGqXOBD+UI839kk0XLcYFRVwhFd833cOmGnpaXf9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787622986; c=relaxed/simple;
	bh=CgMeQe+HrIJJ0uFrYOINDFEjOYyugXhcq0PoTpD7ldc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1Cxyy45dPxgs+ydxCE8fOWhvZBdcydGfpWSD8jS/BcVAA13iNmyzZJvTJQfx1cz2EIUb6eCQVhlBK/t0byRdKOpQqZnr/8G/DLqzdgLVy6KIXLGOto3CDB+xfwwidnWYmQhpD/81/CKT+d/pRESkbwlUxacWxinZtEwS2b2MT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xwm9rvp3; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xwm9rvp3"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbedf433a99so4055475a12.2
        for <audit@vger.kernel.org>; Mon, 24 Aug 2026 18:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787622985; cv=none;
        d=google.com; s=arc-20260327;
        b=EI2MN6ox/0qUOE4CHAeQ9UYq/fuJnBXztQbk/oW0JEpOzZddxW5erdLrM0P+VlgCrp
         FJrEfIlHTyZaUkSyeLAvsyjJjaNATD0jkQsxCIDXddfa+fNwaM+2Yv2I+umbs4Bq1kQH
         0PN+mBu4xK4qBhgPfalChdOEfLfqJrf9AhTYbPUG/oGQgu5ay2GxcsZdjIrrNuSXsN/6
         zQEpJTSwdyjjOKpQIz5/d0RB7lqf1MFTgLVw6XVmzLMRZ+Xt1/yRzfzBLzNFSK4jKn1m
         vSxsNrdEhiNKzwHYn2D3NJQxgIUhtZbWFwGvKTOgai06XMzGQgVX6J5wCm52nmGnmuEb
         K5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eL8Em3XBkkB3ByuSL6hH25sdEU2rIpfCZLeesDeBJPg=;
        fh=B4wqPJC794Jst5xD5CjI0LZGrW0JqqMoPv8kBaC2fzo=;
        b=CK67PdkpPOrEE6zTNCtSD2DDc4oZipdU6fp3mzqR79/eZHqt/MWW7h2rDPnXTdtLKl
         kn3f20Rheo2gGCEA7C25SuO3w/lVWI7dE3DXMlbsM0/sfDYHFmmaSrV/a2Ti6LJkJ9A6
         ZLkQGXummswExYYaAFLqf636keclmz3Qw7+xuGIbe36LhH1lrNZsdguXpNM0MM86/F4X
         bO4BVJVVe3xK/1so336uwJa0EqmDkUvKclZQCSWV+twgEnyXPziu60K4x3279pSN8Lqw
         yiPG5zqKDMO8J01no5bga+TO9G+X3YGIEA8jvQUtvVdEOSrLUBn05lFiGkCasdkBuIr3
         5ooA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787622985; x=1788227785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eL8Em3XBkkB3ByuSL6hH25sdEU2rIpfCZLeesDeBJPg=;
        b=Xwm9rvp3UgIObC4KaRfLWFsvvq7Mh3Rq4WPTbTUC1MLXTNAIQfMXP3hQMrf5zfjYMX
         1OJp0xylF1zaUoJXVqoqAUiZwDoyJQWCooi8YkTZJeJ5C+CI6senVRJHrEtEQ1jZValV
         VtaI4WFw1Oqcb9xse0dfTPU8Geg5392gwqkeVkXjJ2lAyL7KJZlLa1ixId+NkJbaAl/T
         NtzUKuOtKeqtIzXUuxou2bppezRiJSlCGAQfvmfwe0SGyKAozI7vjDV9WXF9bvcgHG/P
         I7yPKPPTevbPoNmAyerSna77drso7at40es8jtz8yTlGtPG7ztrMl0UVmVxFzx/q27wP
         hw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787622985; x=1788227785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eL8Em3XBkkB3ByuSL6hH25sdEU2rIpfCZLeesDeBJPg=;
        b=kCyEU6jK6YIB8nFa+0Cz3FNdTUoCSKNsxLAOkU4C2p0me+uZ6XZMPxtqe4mDQB+3nE
         72IMpGMVFvZsNxEC5V0h5Jv4Ym7ci+FbKS7kqbg5ITUGN1nsP5UHh4keWD+ElcaORblo
         upk5DkY8uSJZZVaApstpes87brw6kUFjGHr9lsXlF5Eys6H6+XW2JyxptAMxiT/Tef7F
         rB8blx+D1EujttEM5eAefGd5cfbNYTgF5VgS0jUkJ+z8bLyRKr6ZyrmEwm73cDHo6SuO
         7qpGHAxJ0/iZcou954dMETzmdbLKOTiBkmZ92XtdS82G/IPh74yLwqFmBLpM3aFaswWP
         JndA==
X-Forwarded-Encrypted: i=1; AHgh+RrdcGSeKNr1nhosFjvZc7/hP8KBAE5m+72PhqvCt++vZMsNuGWv4C9hOr53I4yEFpgTzfRIKA==@vger.kernel.org
X-Gm-Message-State: AFuF++kjUJbS5eRTpPnjXb8VhihPvZeAUvmlI5FfNHweU3i1e2i0+dLm
	Pk2sdCz7EixYjeyLCfGstoAbzTaPP5V/HuBcbi07tRkRLERSdmKgx6CDfj9edV+lbcI0jgI7ZPk
	S3+THKZBMGG49aaa1PG/gcjFAgcxqgedjp08sF/yf
X-Gm-Gg: AR+sD10Pi0if3QAkqABP7Oht0at9QY8txorzVG2mR4oKhhauvNf8cnYbGwG9Pi5eVkh
	+vu6TWLZZj22D8WPrNPtouO35kY97pwcIN+VdXfNKWw51pSxPHkvdOm2Szlesf36ppmKNfdByuJ
	4WhoxZCXHMTGmU+dZS2hQyvJJQeux4aB9nQTGvg0p+VoOv3SUdXQnYdpaXLHCmeAIQ4Fp9ztPb4
	4QdN7Rtj5XMqut2Ez8ocHsyqY+LZQdNNlcK3V4+cXGLmwgH/dEjnOyKx0WzA1Uvponex/kn7/5g
	hN76+fcjFHKnhiU2EjLQ/OpVzCQlKWfm3nLmxAxJMx0FSg==
X-Received: by 2002:a05:6a21:3391:b0:3cc:ebeb:3efe with SMTP id
 adf61e73a8af0-3cd91299690mr6192258637.9.1787622984659; Mon, 24 Aug 2026
 18:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-audit-v1-0-ddd0d94ff0b6@gmail.com> <aos3m2wG3To3wCeo@skinsburskii>
In-Reply-To: <aos3m2wG3To3wCeo@skinsburskii>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 24 Aug 2026 21:56:11 -0400
X-Gm-Features: AcwNN1XsyG_yPfa06rOw21lMzHNipb4bKCM3LRKTxwonjmy8cD3qALFuwXGUsko
Message-ID: <CAHC9VhQUsJyvbu85Dzxobb8wN48o9v9TDCQ=m5dpWDGMFmbTNg@mail.gmail.com>
Subject: Re: [PATCH 0/3] audit: Measure and reduce syscall filtering overhead
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Eric Paris <eparis@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Amy Griffis <amy.griffis@hp.com>, 
	Frank Hofmann <hofmann@deshaw.com>, Noah Orlando <orlandon@deshaw.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 2:10=E2=80=AFPM Stanislav Kinsburskii
<skinsburskii@gmail.com> wrote:
> On Thu, Aug 06, 2026 at 06:01:18PM -0700, Stanislav Kinsburskii wrote:
> > This series adds a repeatable microbenchmark for audit's fixed syscall
> > overhead and uses it to address two cases where audit continues doing w=
ork
> > which cannot produce a record.
>
> A gentle ping on this series.

As I just mentioned to another submitter, your patch hit the mailing
list at a time when the audit/dev branch was closed to everything
except for critical fixes.  We have a doc, listed in the audit
MAINTAINERS entry, which describes the management of the audit tree
and our processes:

https://github.com/linux-audit/audit-kernel/blob/main/README.md

Beyond that, while I have briefly looked at your patchset, I haven't
had a chance yet to properly review it.  Given a quick glance, patch
2/3 seems good and reasonable; it even cleans up some macro ugliness,
which is very nice.  I'm not sure about enshrining an audit benchmark
in the kernel selftests, as you do in patch 1/3, although it might be
worthwhile as part of the audit-testsuite; I want to think on that a
bit more.  In the past others have proposed similar things as you've
done in patch 3/3, but I really dislike the idea of adding more
filtering to the audit filter; I'd much rather see what we can do to
fix/improve the existing filtering.

Anyway, that's where things are at, but it basically boils down to
"yes, I've seen your patches, and no I haven't finished reviewing them
yet; your patience is appreciated.".

--
paul-moore.com
