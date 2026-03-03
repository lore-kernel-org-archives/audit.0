Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F84279EC
	for <audit@vger.kernel.org>; Tue,  3 Mar 2026 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538129; cv=none; b=F1ErBoSMynybODdFIilvuVRzd/lKixldMFdayvL+So/+UiuIlAK8O/H2UtVTGkbD+o2t9mOfywam/ic18o6XFCjdvIlbh4aeUBxHzCCwr5/sq9AN2OGB1LpebimE58RnkFtDXnAfSz+lwSTlupjQQUABbM7H/XqjyILexanZrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538129; c=relaxed/simple;
	bh=mIx1A0NEaO3jSTQIxTRJlQmStn2yHY3xIh2MEd7KjUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUj++M10PzDjvh86hqK5SCwom5pie6BVBGufAQcAwsMffTo4aVEJWndTfxQYNqHS7Tet7WfhtfrUbdFNnjWeV+qfJNgn1AfsqGaU8fmXtcug8UctrZ57/aqxUMiV5rP+72mVJ+m4xAPLPFFshJ2BAevSchjfEK3mL1bFIjGvzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0+2wuQr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0+2wuQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772538126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFpROTQosoRIbVZocJXQMAtUCuys/IFnPzXjY4tNZDc=;
	b=I0+2wuQrpcr8GCt7XlEYXEIodxEQDQ3Q0aGHXtBFxrXv3/GN4fAFBCsFp/CfoH1X+oaiXm
	QidoV3UJP3YisvpV6fAdJhR0UcftiFb39KYL0A2wY/Vre08m8ztk5kZlXhObUBl9QBHtDG
	i8w2EGFm3L0YSR+DVNsoUDTdWkceOEY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-gmjxbku7N1mCXehFpbXgHw-1; Tue, 03 Mar 2026 06:42:06 -0500
X-MC-Unique: gmjxbku7N1mCXehFpbXgHw-1
X-Mimecast-MFC-AGG-ID: gmjxbku7N1mCXehFpbXgHw_1772538125
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b934e96af9dso665691266b.3
        for <audit@vger.kernel.org>; Tue, 03 Mar 2026 03:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772538124; x=1773142924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LFpROTQosoRIbVZocJXQMAtUCuys/IFnPzXjY4tNZDc=;
        b=FAwAsjV+HIPRhpQYuZvR8XcixRIg0pKKvKC31mfcCKga5Ht1xR6LL2i7fqBGlqRvXQ
         TlSgQGCmFUo7+Cgi16Haj6B8meDdQAVZuMI+vaBEdXs9yF5DH2NKBpAifb0vAbK/LPPs
         lcT0nbBsYiO8f2ZWwq7EFsmMARu/LNAg8EbWQG6ptze8Kyt2Rdp7vA0vDI0YDwVLrywk
         CIdm21ICCgN7q3QQFiRc0RgjZobc23YluFKwFyprDmm5G9TXtXSH7F8AJPhqavlMheDw
         TKT5a51ld4PydzrRZ4Z4xBfGYNd/Tifuh71s04x40rSphPm6WXpvLIFQK34MQp8Ez1Tv
         OyXw==
X-Gm-Message-State: AOJu0YxWBeK2X5Rmdrcgowveppl1UlhzkXB5c75zogQ2118i9Uat9Fu3
	ML4vk5i873vWtX/PnE+ti5bZF+izLvLe+SZMHIk4jVfTS2qGECak9BMaSLeXc5slpDs/JuqPSRW
	LoSOuP6nTpxfsN0zVbIsG5YG4I3qDq7KZPxrVpN0tCdbEWFrXH/V6I2MsMsH0zbKTMnHAk6twxj
	YKNvkSutM81FFbIYvM/esgYGB2CvkjbJmj4nn3o5bf9aEB
X-Gm-Gg: ATEYQzzrMNxVzcURfuTlS0Jb+c35Os9TSIOSsGzPCtlJVMDWtqUEk119NUHgoJNrRip
	d9SXI8srrriL3Nw9UZma5YlTm/hZ7GBaL8/+89BsSzdGTPmCMQwOYijwRwZ2K2AGkLCFSKc41lK
	E9JdXZo/0a+v62YVvVH3gXDHYarhvYzG69B18HkBb5PSpy3EsJsGDbLnPHm1JtDBWJoU1Z6VSCO
	2uUf2rHu0UNMCMTvJSM0vhzXmGr5p4hV9pYZ6FdjRM3LBTgISrEu7LPsdzjZIVudSs=
X-Received: by 2002:a17:907:7207:b0:b8f:a26e:dec4 with SMTP id a640c23a62f3a-b9376379d9bmr970193866b.7.1772538124509;
        Tue, 03 Mar 2026 03:42:04 -0800 (PST)
X-Received: by 2002:a17:907:7207:b0:b8f:a26e:dec4 with SMTP id
 a640c23a62f3a-b9376379d9bmr970190766b.7.1772538124037; Tue, 03 Mar 2026
 03:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226171546.2231505-1-rrobaina@redhat.com> <ec57713c0a9c8b1f13f74d1cbb0b18fd@paul-moore.com>
In-Reply-To: <ec57713c0a9c8b1f13f74d1cbb0b18fd@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 3 Mar 2026 08:41:51 -0300
X-Gm-Features: AaiRm50hduSTQzNpY9Xfr-phHwDd6Bp_o7g1dJSU5gYvTlGJD7GVRw8CBgQysok
Message-ID: <CAABTaaC+hwOMWD_o=uZ-b=nJfqU_f-azOnicoOsO17ik2NrV1g@mail.gmail.com>
Subject: Re: [PATCH] audit: fix whitespace alignment in include/uapi/linux/audit.h
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Tx2VDtfrdEhHkXcR44-i6t1eNBO56kvE3jMBPk7DMk_1772538125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Feb 26, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Fixed minor indentation inconsistencies in the audit macros
> > to align with standard kernel coding style using 8-character
> > hard tabs.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  include/uapi/linux/audit.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 14a1c1fe013a..410dfb41b810 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -350,7 +350,7 @@ enum {
> >  #define AUDIT_STATUS_ENABLED                 0x0001
> >  #define AUDIT_STATUS_FAILURE                 0x0002
> >  #define AUDIT_STATUS_PID                     0x0004
> > -#define AUDIT_STATUS_RATE_LIMIT              0x0008
> > +#define AUDIT_STATUS_RATE_LIMIT              0x0008
>
> I had to fix a space-before-tab issue in this line, but otherwise this
> looked fine to me.  It is worth mentioning that checkpatch.pl would
> have caught the space-before-tab problem; please get in the habit of
> running checkpatch.pl before posting patches.
>
> Merged into audit/dev, thanks.
>
> --
> paul-moore.com
>

Sure thing. Thanks, Paul!

