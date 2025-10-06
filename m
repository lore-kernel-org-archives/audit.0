Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71FB20B80B
	for <audit@vger.kernel.org>; Mon,  6 Oct 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744279; cv=none; b=GiP7T6BBNlnu7EfGVmv6129nfFXp/u//rzaWqAwfgz96Uhlqvn9D0OHnhXt8JMWCuR1iYtF67WeNCI4qisrd+3mCf3D+Ju3MRCzvrh5cYHtzqKzgLnCu5rasBYOCalLgiEit+rNSAX9lX6GRpYE/2qkNz3B7K+5ZKc7drRRmaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744279; c=relaxed/simple;
	bh=bHqclwyLkUNjJLc1hzYctTC+iEb5fEGxWqRMdYUGqtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEbLSvHFJ/yAM16+NHgE5Copo9e3kji5o1dqR6VKTF18whJmskuKN6eJ8drWgI6Qieii14SzaIwSiN8xvVUSuWe6Z5xXNva0ZpQGD2PotJ2ZJSAqaiWuNrqw1JSk70GDasc2vFQFnEL2nmYcgd+cr2KvTswDOJAL9oaQSnfmoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RT5+4Wwr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RT5+4Wwr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759744276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxh9Z2NaPYtIW6LVb70fTOamcBkA8Vc9TSWtwP/uZlo=;
	b=RT5+4WwrgSy4cQa6oVze3Vmo5pE80l9Y4t27AiNX55R3gTYx8kcDcufFXqXp7eMwIh8Ouz
	IjMvdqwANWh7WAznCuqQ0NjSIQV4hUXQSqV5FUvvQ7OFHbPv6VNnU/krQYjq1QPZRPnkiF
	ov/tXkV+6PkxHsYnUyyOdccJGd26wTU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-Id6kPhDnPp-FmrQeAS1RRw-1; Mon, 06 Oct 2025 05:51:15 -0400
X-MC-Unique: Id6kPhDnPp-FmrQeAS1RRw-1
X-Mimecast-MFC-AGG-ID: Id6kPhDnPp-FmrQeAS1RRw_1759744275
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b4635c413a7so355772566b.1
        for <audit@vger.kernel.org>; Mon, 06 Oct 2025 02:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759744274; x=1760349074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxh9Z2NaPYtIW6LVb70fTOamcBkA8Vc9TSWtwP/uZlo=;
        b=b79lsiUGSol7DhkT/Lq5yPWjNsbR9SuzQvtsk31PDmJUl2Ull/sYSVI5WCXrDlO06w
         YKUkBTJjmS/DByvjVjHp5y5FA8+fbBHTj1IcmXnWZQhDhC9utr6BgTGKkNjTgRCxiWcz
         iD7QxNdAQAfKTJhQmVsimtyfugYm4vlC81GYbiFhQhNmY+5PfIDMqv3E2aU8/Vni4Q7A
         PhkgfVRs8Qzyd2CsGJg37nNHUKgRnaEiQ8pTwBd6wIiOYIkmmaFJ3IlnNRjmehiWd9ke
         Bil/SlHnhGxjiJBiGIvWFZt9rIJImqS4M7xbG162qNe/gTMJpc8lCp15Rk039W4eHhhW
         roEw==
X-Gm-Message-State: AOJu0YxpGdYzQffftQM9wFKtip0xmCwXTYYGbTFkiG3amjQBDwAHa1jk
	aePuiNPRrGz9jjeEAv3XVCwjtQ9mH3GTBBu7A5IBS4+UDmyV+5yeI9iJWiPJUA8ULjfjr3YW6dz
	gCJTkZSZpVN5su+xfOIlGwvxJkX1pMFZUzE4Q8I/opAiUHJ3Up27QJxqppDdwZ0KUaby1ANsLSx
	Uie+WsOZvtpclgycHNC+J7oTTSItIfNMo=
X-Gm-Gg: ASbGncsm1pr3cut+PVpYSCOVZFQ2iinGrAf78cjg9Bc1SdHZdKtEh1Pb9k/tPczLJDd
	JpWLmbDT542AGxdEsYlHK94A+4be/jejM+L/1/ho678Zs1OMX13gI6gdmDkVcyEI8XoTpDnDlI6
	a3AdUJIlLa7niQPPx8zCDueGLIzVt5YfaM4MVwO7XN2guGPWx6bFBCoV9akdo=
X-Received: by 2002:a17:907:86ab:b0:b3f:ccac:af47 with SMTP id a640c23a62f3a-b49c3d753e9mr1594130066b.31.1759744274498;
        Mon, 06 Oct 2025 02:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUSD2bCGjfaLibGZkbwwbVrVW0T4OZZ8ueWgxk9+Jscatm7Wk4WTwtLGrqSVSARsQZzylgAei74Xb7PbDKJyI=
X-Received: by 2002:a17:907:86ab:b0:b3f:ccac:af47 with SMTP id
 a640c23a62f3a-b49c3d753e9mr1594128366b.31.1759744274122; Mon, 06 Oct 2025
 02:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904165919.3362000-1-rrobaina@redhat.com> <CAABTaaB7SxWZUH+VxyOwZWBi6uPERg-qkMosFA=MTst5Rbc6kw@mail.gmail.com>
 <CAHC9VhSi68-i8om4VYbxRsrK7xpVL-NJy89e01qsa5WTT-hQFw@mail.gmail.com>
In-Reply-To: <CAHC9VhSi68-i8om4VYbxRsrK7xpVL-NJy89e01qsa5WTT-hQFw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 6 Oct 2025 06:51:02 -0300
X-Gm-Features: AS18NWAE2IYvrD6g_3gTlP4iL6cMvZ48OibF5PWMZ7lVDeVlaCGvMRgAbDQeWkA
Message-ID: <CAABTaaAW_a7_8WD8hsJw5X0q6BKcy82pyigr0HJHCZn0==KPTQ@mail.gmail.com>
Subject: Re: [PATCH v1] audit: merge loops in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8het4WtEtC5hxoVSQBV9zhbNzaqDrKaKOWxqfpvRsO8_1759744275
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Paul!

On Mon, Oct 6, 2025 at 12:21=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Oct 3, 2025 at 11:50=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > Hi Paul,
> >
> > I=E2=80=99m curious if you have any thoughts on this one.
> > Please disregard this email if it=E2=80=99s already in your to-do list.=
 It=E2=80=99s
> > not my intention to rush you in any way.
>
> Hi Ricardo,
>
> Your patch was posted right before v6.17-rc5, and with only
> approximately a week before the general feature cutoff for the v6.18
> merge window, I didn't have a chance to properly review it before the
> cutoff.  Rest assured, it is in the review queue, and with a little
> bit of luck I should be able to start working through that this week.
>
> As a FYI, the doc below describes some of the basic process for the
> audit tree which may be helpful.  If you lose the link, it is linked
> off the audit section in MAINTAINERS.
>
> https://github.com/linux-audit/audit-kernel/blob/main/README.md
>
> --
> paul-moore.com
>

