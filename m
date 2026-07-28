Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B841F349
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278743; cv=none; b=NTqt57dG6u+xSFFv+0S3GlPSTlSuDucLZ9vPFgXPf+Tl1dsM2GVvoB2Rj5HqehpX1aXpxlBGMwV4wvjidsrJXuxxp6OQSL7tIrpqZmea86tXz3GvBPlYN9SjyqiqBnBIbELCEXC8Ck7Jzfx/YxEx7LUaH3npxc7g8f7dynXhYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278743; c=relaxed/simple;
	bh=zeKuJSN8tm9YUNagRhwKhQhCErA8c7nbvYm0snLHq4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzVLM06fqJI0d/gOLo/cRiDy/MCVwGQb4avxPlwpszc4om7jBQM1kMheK2WFDmXTuJWyK8nlHyXAdgGVTLIq8Rrqonp4IhbJ++lY4HWHQtkc6+5zlH7Zx9R5j8+GlypuvxQYcrVbHWFcC+7VDMoibwDV1rIcmy4i/vMaX4V/rGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8GBIAAh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8GBIAAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785278741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5d7afwXMTyGavP/HmDXSn0c5Hwii5oq80hS3MT5Mvk=;
	b=N8GBIAAh+8GlP2cnAaEVxXcWbtjivzWMmLDwdAAn7gP43u4y/yaxUtW49Fbq7J5U4g6+Nv
	eyNhP1BSRHmuzqXi8fv1v9nyi3GbzA6iVEN4CSYLG3bis/cIrgUAz2osi5nDOGi9e0vZHO
	xiDuES24xMh0h8gAnny3lvgaUK7CoQI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-ucquvLLhPWeJ7kVt7E46xw-1; Tue, 28 Jul 2026 18:45:39 -0400
X-MC-Unique: ucquvLLhPWeJ7kVt7E46xw-1
X-Mimecast-MFC-AGG-ID: ucquvLLhPWeJ7kVt7E46xw_1785278739
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15c32294e1so34440266b.3
        for <audit@vger.kernel.org>; Tue, 28 Jul 2026 15:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785278739; x=1785883539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5d7afwXMTyGavP/HmDXSn0c5Hwii5oq80hS3MT5Mvk=;
        b=abaXDB8Zn5EBUSNO55gr6NTn8EnCNfXn1DetbFs8qw+k0yxnDj7lPb5q1qUygSkIM7
         e+cexXwodY8QNO6yF4snFeWwoAHRLpgo/1BDWH930fTaPpjs/J4I3HNbu5ZlK3GWdAol
         LIJ15EkZ+b9ZPxv/Lcz7VFAvkBd/ne4m32rSPz4COJJhh8mwkB0tuLfzWhMoKOn8mvfi
         zqWGTLvF8H0mfc1Wji2GKYexw6QqWJFBg59vcSRfy+Jz56Q4KlpLVujnegO/3/1TFz//
         qxUa2BwMwd+gMOLNXY/zHy8Bx1l+9M/XeM7AtxT2MCIxNgvOBTvzqYOW0TqOLcprnI2w
         EFlQ==
X-Gm-Message-State: AOJu0Yy2r8HvFPpnp2hczE1LcACpNScP3CAfyVsQMRpf8B/yBbhI5Mdo
	czlXnGzzzOwyYvJDt6yx0SX7aClSO+S2ajDjkS6EABEoLuS9eVSvfk0imxKwslGSamf+c3bov0h
	nw/j/XB2y+BEQWO9xqT+5mDdDYtnGmFseg7bHSFCuG5Ednc6CWNkh1B3c3rHqKkBJSeNcL+HAL6
	7ESui5uwhv6vJKsJVgIg7wioQcieqT8uc=
X-Gm-Gg: AR+sD11Ur7vrSo2jLcT0scFFnky6SG0++LdK41LC1IsWe8rZoWGzYLdvWiDykmpcm2Y
	yxHj3ElKmaX+zcPHUrGx1OSt2DbhbgzMeftJw1v8k3Rw4xflzf4z5EU5drSObSHvpVWQEN5qSaf
	i3SVsdLD10kcYeQlU9StfbEuFFVtrEUX47oraMeXjo37WG1uC2BDvSHn/Ae2PI83oLQKAhSdjQJ
	DDisihn8ffbMyxk2t86G3Ou0WbijFo0oVeEXXTk7VoMqrkL0jaQ7cvt/M1WaeZ0yvKRb+JdcUZD
	PCc=
X-Received: by 2002:a17:907:5c2:b0:c16:55e0:ada5 with SMTP id a640c23a62f3a-c1f720f0beamr227077966b.35.1785278738716;
        Tue, 28 Jul 2026 15:45:38 -0700 (PDT)
X-Received: by 2002:a17:907:5c2:b0:c16:55e0:ada5 with SMTP id
 a640c23a62f3a-c1f720f0beamr227076666b.35.1785278738366; Tue, 28 Jul 2026
 15:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e0e6505a3f80912216dd834d25f330b818d73263.1785246707.git.rrobaina@redhat.com>
 <176efbd2097ef7b8a25b09b5e1f7b2de@paul-moore.com>
In-Reply-To: <176efbd2097ef7b8a25b09b5e1f7b2de@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 28 Jul 2026 18:45:25 -0400
X-Gm-Features: AUfX_myDfqGsJuogDW6y_6zG1kMJM3irsDDwxClh4AkxZFbBbBpKO_ae2_IBmtw
Message-ID: <CAABTaaD3QG-ejOzuP6xC1yBM+jK23WQ_MgsC-HYBb93=wR-7FA@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: drop BUG_ON() from audit_add_to_parent()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f9yxmSmxt-fmPE_KzZsY0RtziIEdXc1voCdYTjk2HNM_1785278739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Jul 28, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > The BUG_ON(!mutex_is_locked(&audit_filter_mutex)) check in
> > audit_add_to_parent() will panic the kernel if the mutex is not held,
> > which is too severe for this situation.
> >
> > Replace it with lockdep_assert_held(), instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/audit_watch.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Merged into audit/dev, thanks.
>
> --
> paul-moore.com
>

Thanks, Paul!

