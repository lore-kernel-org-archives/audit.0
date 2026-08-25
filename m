Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B951D3FFFAB
	for <audit@vger.kernel.org>; Tue, 25 Aug 2026 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660137; cv=none; b=MawHOaKpdCmoNRBZ2qlAZAdvZDYwVnEsFTdXup0mk+1+1rWpY/1eMwfquUzYw3UU9xsfVYEgldwCxu6BJmVP6KASIDxNUoy9yy8k6XcILDFFkSh4vSTh073QF7og+YBl3i+Hy/oaxI4vvp1hmHAlkgDU5yxquteKAngt8wMXnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660137; c=relaxed/simple;
	bh=eOG1KEVngG6WgAQnlSBv/N+E8T2ICYSaZB03VMM8Pro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zu/z9jdmdOUEe36i9zDip4DXu12OwpqjnBfjfxeyGgQcDf99JXhsrVV9alQKTh4TlFokoW1O0OWXMHTDE+cE3znnqFF/cm/Tq7pRW6j69OViQOZjzrQHMWUvf0TXfpjX8tr+cH+spajWUOVbAxcUv+hBPg33gdvlcoTpEejHysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRnubOET; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRnubOET"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787660132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsAza80Qx9hGJQjCBEwv4vd0haTp30Zh6Jk8vpFUKB4=;
	b=fRnubOET8vWs4UbiT0CLfaThfJUatP/ct0W/hFtHyEWAPj6bjrIHbWBIVv2meg9ftdrF80
	Vexu8/dCCkodD485f3jyXdaflq0AqaVmJ3y6o6IFyFjPKDxT1niwmiAWqPiW7d1iZa/U6N
	//Gf7wIYMvSCyvGtr/vCvqyWdpTKgy8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-grdTP1FyOD2bxpKyM06yiQ-1; Tue, 25 Aug 2026 08:15:30 -0400
X-MC-Unique: grdTP1FyOD2bxpKyM06yiQ-1
X-Mimecast-MFC-AGG-ID: grdTP1FyOD2bxpKyM06yiQ_1787660129
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15ddb61f13so427579966b.0
        for <audit@vger.kernel.org>; Tue, 25 Aug 2026 05:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660129; x=1788264929;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsAza80Qx9hGJQjCBEwv4vd0haTp30Zh6Jk8vpFUKB4=;
        b=VUDGtfox8F0yOHefwYwcLLuQXQGuWOYrANNv1ogTkRCCMmL+ZjyIRb6HMIGHMuHZS2
         6ToPfSXclFAoA8AZp0qko65DBG3o4bzwi3CGOaJPJ7smB/OjXeZIeZLE0d287tiZq2Ic
         5PUmKm8Vnh3AsiPrPUioU9FFgmYsIloq3IfXs5jYeDG0A68mzPL2I7US/Ris5p5tZsSt
         0tSJFx4hXBKIbUiQSq7HLLb+lKUSwUNj4D3ETtcDKFN1Oez/IghoDFDjs+MfCTMrFbcr
         5U2LksoXkgWFI90PFnJYUATggaSbDzqqWp7wVOEQlx/FUZ97G+tlI6RBBdMjDh52hMA4
         ye7g==
X-Gm-Message-State: AFuF++mkHuzvFhh3+PzvynfzKPaGyatnJ77/GNhHgB51DjkkVa6xVUDT
	7lvP/6x4R62PP8Fy4OwxtRvVn52tzYoepyYqMBsYFy4dR5hwlpCcHoP1q3UgxAe+Nlh8WTbew3d
	FP39j7xO29TvjaL/CPAtfeLvXDo1UUZu1gYg3oVSbzVB2HLCq8ciiF4smgDA47XkUuQk9icwBnR
	Zmr0hjurKi9CJOL6T5YRrNke3OWQq32Xs=
X-Gm-Gg: AR+sD13suXowhAXxHmRpJUnARYnoovGEqrYbWKGQtv75EvbI7fXMCDX00kUpzMEXJb1
	2FrPxtnvSTwWS2WrHPBVmocO3ByTXUb9+r97WVGk+rRUxui2d3krNgAlAdw8veRCwydTpRPeXFS
	teQ0ZpAEZdq7eThvBnctupVAWlVspDZnBvb8FezTQrGctQR3XIW03yTNdzWL6Ar7gzPA9d/mBNG
	KV2W5Q27mDyh4EbMlslHsPCstCa28h+hxvqdtsGQH1MyxvEZ49dz4/cdXjDnWKS6zAlDqEjGbpL
X-Received: by 2002:a17:907:e14b:10b0:c19:80cf:4c75 with SMTP id a640c23a62f3a-c246a6ab42dmr3257472966b.20.1787660128824;
        Tue, 25 Aug 2026 05:15:28 -0700 (PDT)
X-Received: by 2002:a17:907:e14b:10b0:c19:80cf:4c75 with SMTP id
 a640c23a62f3a-c246a6ab42dmr3257462666b.20.1787660128278; Tue, 25 Aug 2026
 05:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810125726.775689-2-rrobaina@redhat.com> <7b9f43325dc569ddb689b02893bde8cc@paul-moore.com>
In-Reply-To: <7b9f43325dc569ddb689b02893bde8cc@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 25 Aug 2026 09:15:16 -0300
X-Gm-Features: AcwNN1UPu78DnZ3IiZKiUi2ZemJYjaPqM-ebAg4jh-1gsLZIvdw_JgbBmQG_2tM
Message-ID: <CAABTaaAK6NpKzSKpYE8M1Zw1neCAr3+bpiZqxko+kfjkWjZQWw@mail.gmail.com>
Subject: Re: [PATCH] audit: use copied skb length in kauditd_send_multicast_skb()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BABY3TkvB6hfgAlTTucsTeTB75k1bXJfmkfRqYYqsJs_1787660129
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Paul!

On Mon, Aug 24, 2026 at 7:25=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Aug 10, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > The netlink header's nlmsg_len was being set using the original skb
> > instead of the local copy passed to nlmsg_multicast().
> >
> > While skb->len and copy->len are identical at this point following
> > skb_copy(), it is conceptually cleaner and safer to use the length
> > of the skb being actively modified and sent. Thus, this is a minor
> > cleanup only, no functional change expected.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > Reviewed-by: Bradley Morgan <include@grrlz.net>
> > ---
> >  kernel/audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Looks reasonable.  Merged into audit/dev-staging, will be moved to
> audit/dev next week.
>
> --
> paul-moore.com
>

