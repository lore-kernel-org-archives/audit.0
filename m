Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4E423EAB
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892822; cv=none; b=DLchew6QnF6fpssRMcP/ztFvNjWEpDpkA1HUrSoaHDsOJ2qMBimgJqYEyZTRK4fiXlUMQBhG3V7gPD0hmPWdXE4BNJ2DHY/oyVIbshonFr8nGIZdu0uBOS8UmxxcsZpOfDJXeHWqravOw8P5fZClVxc1VeucB/GozBCjzVnm0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892822; c=relaxed/simple;
	bh=26R0OtVGgKl3HlC5Lox3tIFbYDf9yfybPP7mdBezft8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cE0Vt49FiAMjxkktqEglIN3dZgxSyjlpxgP8w4PYTJmIZ8rKADyiRDiAsPUAnbME8BwQ/SwQqKI0cvJOGIZ7jNk0oX++yEdoz7Z2C05268SK8UQqbHiIF1pE2+Hd4OnQHef5BJ1O9xfR764UUL93M0o3NNt2QTOJJKFN+NGvNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdI263Ht; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdI263Ht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784892816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/f5+A4XTRrkq1Mcp0vZ6/Hk6iKLE/BsvGGag6FucPc=;
	b=PdI263HtIiC7asUcFV9BEYCIfvVkDYaFjlO/LU8nw51xnaeyaWxQF7QjBRvlVN5I5ihxVE
	qOBFo+rAEsGnR19YSnBwGAk4M7U/0bkjDePStou/yoBGNHZSntd8I/zgOYmtvq9Y5fbqaS
	uHr4Kit7ZOEDtuleueFtnEagf6hiJIk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-9KeCymUUMX-r0BimS8L2Bg-1; Fri, 24 Jul 2026 07:33:34 -0400
X-MC-Unique: 9KeCymUUMX-r0BimS8L2Bg-1
X-Mimecast-MFC-AGG-ID: 9KeCymUUMX-r0BimS8L2Bg_1784892813
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1288e572c9so48413166b.0
        for <audit@vger.kernel.org>; Fri, 24 Jul 2026 04:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784892813; x=1785497613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/f5+A4XTRrkq1Mcp0vZ6/Hk6iKLE/BsvGGag6FucPc=;
        b=hKB1yz3xMic65D9yVM0oO8gzPpPvMWEJIreJQwJggV4Bs8v5Q2hYLhH20AH6dJAS0W
         OXH8l4hifENswwJ1IC2zAB50ivGT2J7vPCfbCMtbo3sNgpxKm8r4TWsDgpCPG4CmE0o6
         b+s5EczLYK2CmabulY+DntOZ/wJOOw/o2JWlznH2BVS8gROKLmpmGppJG4q4IVxLaKOa
         kBPGlrLj5e1x36EyzYDoQgEYeq7hFCP5tDi6zaAoBkD308Kdq2NNpdQKd1GCj6tEv7sl
         VmuP9seT2XuJUe7STkwVoeSogDjAGN1VHS6Yw2EuUFengiEq9lWGyJC+uIFcTY8YaQZA
         frmA==
X-Gm-Message-State: AOJu0YysTiqzkHWH2Bk/FpMm30K2ZuxhXXyPSPu45sXlVIMCAGTW74qu
	Ggte2GaYYua0HtwN8Ttl1gmYS7QpLz1R7F/uTwzo9aRUZnmxPTbRyTFL+Ue1v5w1ugg+AzVk1oq
	7IbYlrSCiRmQ+Mdlc+07MzZH5NfnbcbG6hYALOf/ET8dbuOo4YHIqXHYqr3mMVqGwFQfOQ7wcUc
	rhG9L9VVd0yB4tooqTnF1ul+XJWMFPH5Q=
X-Gm-Gg: AR+sD10gNxFct0oU+vIrHrlg3nl9uW8SxET1PJZ2G6LTtAYIc5nj7SNws5J3XfOuhxk
	MuxY5ACtxz5SGDWOcJl0VG03QCPf4+Wsw/IhT2WblBjjSjxLVRxhMm5bOgf7pfw4DqV4V4a7PbN
	976mBYICqWiYwnnPUAGec3bs0W4cvjbccpZbH0qrRo17d5Vs0OVf2dT2SC5A1plKHvIFXkzxG3k
	99VkevkfBhC/MKynRSWipZZ3s3Rnn6kHQu6drcTWKlibYEdObd56oLH6bVxRwBkn58t1o4+b3V2
	FxI=
X-Received: by 2002:a17:906:1004:20b0:c1c:3b06:ed24 with SMTP id a640c23a62f3a-c1c509eb936mr225813066b.28.1784892813490;
        Fri, 24 Jul 2026 04:33:33 -0700 (PDT)
X-Received: by 2002:a17:906:1004:20b0:c1c:3b06:ed24 with SMTP id
 a640c23a62f3a-c1c509eb936mr225812266b.28.1784892812975; Fri, 24 Jul 2026
 04:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhT5pLSGx=-QzA5P6xiHgEPmgZfy4eURe8SQR40d6Qt7Mw@mail.gmail.com>
In-Reply-To: <CAHC9VhT5pLSGx=-QzA5P6xiHgEPmgZfy4eURe8SQR40d6Qt7Mw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 24 Jul 2026 08:33:20 -0300
X-Gm-Features: AUfX_mxFkjBkVpxrMAzIlnn91cJ_AO_zdppqlwd6USUL7eMoGrisRx3m38FTA0g
Message-ID: <CAABTaaCTMPLpgp8J9SaY_uXpy0RGqrt54r=cuxr3DpiKYJnKDg@mail.gmail.com>
Subject: Re: Enable sashiko.dev for the audit list?
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rgode4odf_Aw3uq_KICJWkGMi0lp-A8S3CYeNjoSuSM_1784892813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 7:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Hello all,
>
> By now, I suspect everyone reading this knows about the Sashiko.  For
> those who do not know, Sashiko is an LLM review bot for kernel patches
> that leverages Chris Mason's LLM prompts to automatically review
> patches posted to enabled mailing lists and optionally provide an
> email reply with feedback.  You can get an idea of the type of
> feedback it provides via the web UI at the URL below:
>
>  https://sashiko.dev
>
> I'd like to enable Sashiko for the audit@vger mailing list and allow
> it to send feedback to the list (and only to the list, we could expand
> it to the submitter later), are there any objections?  Alternatively,
> we could simply enable Sashiko for the audit list but keep the
> automated email disabled.  While less convenient, the feedback would
> still be visible on the web UI.
>
> Thoughts?
>
> --
> paul-moore.com
>

Hi Paul,

I think it's a good idea. Regarding automated emails, either way would
work for me.

-Ricardo

