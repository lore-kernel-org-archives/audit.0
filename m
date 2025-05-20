Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1F22DA16
	for <audit@vger.kernel.org>; Tue, 20 May 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764547; cv=none; b=a+zWIcsSskN7bGJkfFTWh7diWffEOUbX2anf+Q7RNdVuWF/XiBY3gIAI6l33+TwiNDLL7HmVqA4qmLCLqvnHHhva735KaQd3zfu4oEQm0cWyEIIZZjxxRRC4FbZYXHOSen+yq47o23pd2rY4kZkVzeiiNg3jtg98ZnGy5kss5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764547; c=relaxed/simple;
	bh=BaHb9YepuQP9xeHP9Bjcl5awLxF3SDbjBMq2/oSPwMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RU4iTStK7TXMYcCeViobr3VfBB2stHEfJ6ckWVT2fZsrF15CdRXe6C7VD8N34KWn66B3hs1z3rh1HfaaO5MPSSRHD+25K9SERkvprI+9s9YA4gjL7kvznX9z+eiAF7QFBUwiMskwAZyYFO28SfSXcZPLG+nSKJZ+kDsieq9gbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZR0u9wVD; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZR0u9wVD"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70cb334de0cso33603787b3.0
        for <audit@vger.kernel.org>; Tue, 20 May 2025 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747764544; x=1748369344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU5udPTppsA55f4dR4/qInsRJDN9j9dX+VCWH1iJNOg=;
        b=ZR0u9wVDuhtIZjvVK6P7ZIx8ZC+Jfsz8zMXZCENHW6Q1spqYxp1fgHcUovF1clzN6x
         jYgRPW0qPRdQCf0YY7SO2qPzJ3JHd0jaHTow8gLRq212/xPIjAZml/bO7eoDghN2nupM
         Q7BPZXwtz2k0DiYbfoHxzbiWCVHkwocI5pAMDf/nO0JhMsKePZUFAGaXZWlABRAVaz2t
         jBHnqBCawJf5RdJYW4foAuahMe/irze9tmjYXphOdDvZwQ1ZUPIzfk/SmvcuzT2A+oX+
         uZLZxHmghka2F7wmJEWFtEQHZwtqcssLUTuJLDc5tQwdVr2Cn9eL3xhxOIY/mfMpw0aU
         S5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747764544; x=1748369344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU5udPTppsA55f4dR4/qInsRJDN9j9dX+VCWH1iJNOg=;
        b=GABcPb5bOj31B4JyCCPnw3P6prGjjitSGLtyvfed0WfFyNYlfubi7oe1N/i2U/VOiF
         7z/Phz/IQoyr7koXRFtByqCEKt87DV47ms2d0O2AzKkV07QlrbIYdBaVRN6HnKkMQw0/
         7sBEYWyq2E3i6CzCMjwv3JSVpWAMmaL6SCMLVsK8gRYaICP71uET2AjF2LgZH2ceXo+6
         MiK95med3Kx0XpmmBftUTkxLb2Cylx7CtxBvBhUyLI3R8BdZpHs5sg52LpSiw82lOYHy
         /1vocfGGLs/GGYbJ1wniwO9z4vZy/EAR4JrI5elQ74ttHdhRaCgwucJDEOE8vmJZcA7E
         /tAw==
X-Forwarded-Encrypted: i=1; AJvYcCW+XIKpJXqnntYAqaugn3JmbOOwDSEIU4UT+TlbW7DboMx75d2jTAfVMOVbSkLG54r0vHN3nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NUHEZoEYsfg6VZDMdHttFfmqEHM28dKqqPqwMieVyLcXiInF
	AGz/0k6exXm7w9ei0ZWoCxH1Z3K/j72pLjBauuqe6tUyJy0d3B7qvYoLYYxFvRqcMNFtvrNREiB
	nB46HB2SIidtSULBg6ENReefRzlqja3So0Eq7hY91
X-Gm-Gg: ASbGncuPVBbOo2kB4nGTdEulFHS1gaEXRdf2KBRCT32FtVffV+vrOjnKPWEUjj7ufGy
	Fp7jSbBiR2fmtGXeluNQBn+dNOgMU5CvsfX6CYjyCUWRyUVxcJCqarCVLwZhJk6JpKIml0tj5C7
	4auQthrG5LCpP7xFYYQyoXicfb9IVeZvt7
X-Google-Smtp-Source: AGHT+IGNWng09pZ5ljk/Okxa5nCSJCuR564MKYI0xijFRLTiDNOVwhoe3rjTtp+IDNpD1Sbw9/3ctQDVNFoPrswyl9o=
X-Received: by 2002:a05:690c:fc2:b0:70d:ee3b:bec8 with SMTP id
 00721157ae682-70dee3bc898mr20129937b3.16.1747764543919; Tue, 20 May 2025
 11:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <669e1abd542da9fbcfb466d134f01767@paul-moore.com> <20250520163355.13346-1-chath@bu.edu>
In-Reply-To: <20250520163355.13346-1-chath@bu.edu>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 May 2025 14:08:53 -0400
X-Gm-Features: AX0GCFs7DIkpyyhcy91W1pEATOT-GDHk2nbEDGbNZtBIXc8wd9A2olpvkvz8kXw
Message-ID: <CAHC9VhTx72aCwfR7rOCmsscEJBPHkDqdsJePGP6eW=DE0ZUSWA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] audit accesses to unassigned PCI config regions
To: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>
Cc: Yunxiang.Li@amd.com, alex.williamson@redhat.com, audit@vger.kernel.org, 
	avihaih@nvidia.com, bhelgaas@google.com, chath@bu.edu, eparis@redhat.com, 
	kevin.tian@intel.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	schnelle@linux.ibm.com, xin.zeng@intel.com, xwill@bu.edu, yahui.cao@intel.com, 
	zhangdongdong@eswincomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:34=E2=80=AFPM Chathura Rajapaksha
<chathura.abeyrathne.lk@gmail.com> wrote:
> On Fri, May 16, 2025 at 4:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
>
> > In the commit description you talk about a general PCIe device issue
> > in the first paragraph before going into the specifics of the VFIO
> > driver.  That's all well and good, but it makes me wonder if this
> > audit code above is better done as a generic PCI function that other
> > PCI drivers could use if they had similar concerns?  Please correct
> > me if I'm wrong, but other than symbol naming I don't see anyting
> > above which is specific to VFIO.  Thoughts?
>
> While the issue is independent of VFIO, the security and availability
> concerns arise when guests are able to write to unassigned PCI config
> regions on devices passed through using VFIO. That's why we thought it
> would be better to audit these accesses in the VFIO driver. Given this
> context, do you think it would be more appropriate to audit these
> accesses through a generic PCI function instead?

I would suggest a generic PCI function, e.g. pci_audit_access(...),
that lives in the general PCI code and would be suitable for callers
other than VFIO, that you can call from within vfio_config_do_rw()
when Bad Things happen.

Does that make sense?

--=20
paul-moore.com
