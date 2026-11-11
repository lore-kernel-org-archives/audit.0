Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426709;
	b=2DuZspFuM6r7YilUGhwLSMoXBCBwzrY3cButrEnCzcSW+YghSCDVnT5+bSZ5PVT9f2wa
	 1t9jGxaaluL/pjT6Wba0bF7eX41HzTy2+vKxp6uUDvwN80mA/fG6iKrOUzCRXDCCZuKxZ
	 r87RU7W/kYleR3Vubw+um7+/NFw7a9hgNGZatt0Rx+DxlvwKAKgSRnK1tfuV1VxHT5QD4
	 W1P4hNNO1YrHSsh+Z4lFKGZSMQK6m7iUxCyiFvJSMXbaFrBznitLeos7yal6Shti6pxhA
	 2W/DF/uX4K3gWc+unrT06Uri1eoUbln8hTmPwZtKuG0ZhGLm3ST5MTrQUby7+yvnDJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426709;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=13YqSnIhjrSGBdnncrmkRLcLAqs3gUqrk+ICDgkhd5A=;
	b=PWOtwrXCc5HUcUPXJ+RH7HghgGdIuaT132vcOLmGDsV+XjX4aS2S63KgY+4ZdZAH5obq
	 oZv0dhBH1N4tPyxitzAexEt6yD76fpgEQko4nURR4/q7aj4e4VLSDIvvIO07xSxFQyrMv
	 vUf8cfO260pLRJxDr9rE63ZDvsy8pqWuAiIN6MiihI+nUv7yr9Mbda6lrLy8iwRA7qa4v
	 aCpMmnmevlbdizukJUNWmIt0/wi4lFU3H/vJUp50SPHiQrH1ZpiUhrmyOUX3R3btxLFW3
	 r6aNtfQb8w4yKGHwNuapMAgh4cl6vk/91fMMASqfVtjEN4w9obB7m4k/BkXniBWylig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bR14ee2s;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5F606A31C
	for <audit@vger.kernel.org>; Wed, 11 Nov 2026 19:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAE5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bR14ee2s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794426707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13YqSnIhjrSGBdnncrmkRLcLAqs3gUqrk+ICDgkhd5A=;
	b=bR14ee2sTML+z8wHq+6wWOLy8acuyvOGPOTb7ymXIohTEedoRiq7I33vrSuCCJeWEAnloe
	yw6BaEvmvrlspRVpc+BkEpEG54PALjZk1UXOBR7aBvta9q/ZmWT+VoZ7dBE5jTLb2vFQ7I
	+OruPCCkxPjCWcdpEtf6x2TXYYBlkDQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-LJ7bjTSFNxCWRrwAfjJH-A-1; Wed, 11 Nov 2026 14:51:46 -0500
X-MC-Unique: LJ7bjTSFNxCWRrwAfjJH-A-1
X-Mimecast-MFC-AGG-ID: LJ7bjTSFNxCWRrwAfjJH-A_1794426705
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b76329afcdso2079530a12.2
        for <audit@vger.kernel.org>; Wed, 11 Nov 2026 11:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426705; x=1795031505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13YqSnIhjrSGBdnncrmkRLcLAqs3gUqrk+ICDgkhd5A=;
        b=wh+QNBrs5D0W6tPOckFXOPsVOTloOcPT5ohu71zQ4jjPi2AyAVIvFymS9U4T2xLECW
         aRWdfWbkxR+MvviQEyh+attytlAHFke6N9t+B/K/8/Cec5IzhTfblTFk69Y7VFy6qHBl
         8XO14Co805w3/gT46LMgORu7ehWS5WkEKnoEH6JIukgc28myaQol1c0SNcrwfAS5UXuP
         uaKQ3Pk9UGuSgohX6Oek6p5zeiLoA6fkwIq0ZXYoAdL0pbXqdijO3S0E59gVc1nahecr
         HoJQ3QsEm3JE9V0PvWzqgML98c93MWcqNF+PkdwkIP+85TFjiGEUQBKqmB0a/eLav7SW
         rDUg==
X-Gm-Message-State: APuU4Z8HkPLTXdh0zi5m6xY7/9OYN/MLmYDDU5j1FRMs+WFOjVauGAio
	B7W/pf7KTZlsAbhjltDb0YJDUmECx0K3CqeY1uSDzT3O5K18fVIYDGEF3yRPv+BVnU2tnCi99Fw
	Z9aPAJT8e9oLytSIA5i8L7s/Cn7JvV8R4lSIZDaudQIV5+6Y0NrgRP80jOGDFqeGEUslmUJjoS0
	d+2FAhFakR1dN+A0U2dnDHolE86SAn6OdCNQSBkSAW2g==
X-Gm-Gg: AYBFou3cebEFe/33qCuwhjHkZ45pruDpJPrqskKY/8kveXFj6ZqdvzxVNx6brAsgBnS
	Bg+llN3u4byimEecKeBJBpO0G3v6JaZOR+HAWz62CT3YETwmY57cuVu3zzkj+82yzSMEpdy/BJI
	iB+5ydIgK4MEEXmmvAoBEEE6nAx2YGaS2uvi3ZQlEoDr+rpxlNeZD2+GY1Stw408gILy1xDreRB
	L0hOYp88m9GP/lSX35o/IchDqaz3R0mq0TpGFpP7G1o7g==
X-Received: by 2002:a17:907:ea8e:b0:c46:ca3a:10d5 with SMTP id a640c23a62f3a-c5066cc8684mr274077366b.45.1794426705309;
        Wed, 11 Nov 2026 11:51:45 -0800 (PST)
X-Received: by 2002:a17:907:ea8e:b0:c46:ca3a:10d5 with SMTP id
 a640c23a62f3a-c5066cc8684mr274075766b.45.1794426704946; Wed, 11 Nov 2026
 11:51:44 -0800 (PST)
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111152057.59798-2-jeff@bencteux.fr> <sashiko-outbox-209282@kernel.org>
In-Reply-To: <sashiko-outbox-209282@kernel.org>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 11 Nov 2026 16:51:33 -0300
X-Gm-Features: AclHuK-8KRi28-wO7lCotvLzx3R8YClP1yWzaHbkuRqhTMvlvvdXcMtNFCDLN6M
Message-ID: <CAABTaaB9zXgaM2uUMQ3h4nc0rERCDf1_OmSR5mfkxid3bFFNfg@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add missing syscalls to signal class
To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NAeRPt4uMF5dYvJi_ls9vHtcWixLOMhhB9PF5HYFb4w_1794426705
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 1:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> > The pidfd_send_signal(), rt_sigqueueinfo() and rt_tgsigqueueinfo()
> > system calls are missing from the AUDIT_CLASS_SIGNAL* class. It seems
> > to be used only in kernel/auditfilter.c to increment the audit_signals
> > counter.
> >
> > This counter is used to determine if information related to a target
> > process of a syscall audit rule using signals, such as its pid,
> > should be logged (e54dc2431d740a79a6bd013babade99d71b1714f).
> >
> > Information related to signals sent via these system calls are
> > currently not correctly logged. The current patch adds it to the
> > AUDIT_CLASS_SIGNAL* class.
> >
> > Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
>
> Sashiko has reviewed this patch and found no issues.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111152057.59=
798-2-jeff@bencteux.fr?part=3D1
>
>

Looks good to me.

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>

