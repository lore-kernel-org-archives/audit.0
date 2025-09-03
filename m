Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182222D839E
	for <audit@vger.kernel.org>; Wed,  3 Sep 2025 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932456; cv=none; b=hUIWe0HTZC7pFIEDnO2wXVA9ZqKHAp5lidwYXbwOaUnmon6saWGL30kUG7l3fuJ2dCU0Veyw9AuMyFFHlFr7MIzNkkxsyDay7AWpNwbXmRM+WXqRJNfZmJOOvsNnhToKgGdY1ueEl1XFWrQBJLggxIshRthcEPg+yyJrqgETB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932456; c=relaxed/simple;
	bh=xOX3t1tNI835fQlZszqsBPrAw0emLRXFXBi/KdgVw70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAWwEzINfY7U43pZ9T8PtODX1Xpam15brBanvWK2IuHXRaOdH1DtFYJh1lvcL8YydhfvO1MhL+tVq5sbTbC/A7e7T5AG/8pkdA12QY6ITBVsUVUsRaCV7Izw0G05LR4atHEDmRcU0ujl0YOpjEZq7yV37Toig+lH4l9ltzjNPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C1N71Y6+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C1N71Y6+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32b60a9aa4cso169736a91.0
        for <audit@vger.kernel.org>; Wed, 03 Sep 2025 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756932454; x=1757537254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOX3t1tNI835fQlZszqsBPrAw0emLRXFXBi/KdgVw70=;
        b=C1N71Y6+eLpqZ5S3RMeBIKzkGLZ0XQRxsplDdvpKyUQ++ak1N0Xp3YH/E+ovePURuP
         +cS4zVIQBxHdkFxymI6oWmdMLmzq0mwYy8muL1v1k0REFlOsU+Ut68txVQbSrLjSXb/8
         T6StVh53IHsgu0mBwK9XZ7f6q/BxtP9mpp3im4CLcZOE4bdLBE03qnznkl+YIaTCjFwF
         y0AAO4j1oonCYYtKLV44teSxkTMteiz5JY+fC+0RyjmLupeAV4sNgqLiFb7k2sSKK/3G
         a2a5vJ33lg82/KqsHJ0hIM37BRVy8l0s9isEpuIs0lA36UYxPFKsLKh4mPFZ8I8qS3Aq
         JTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932454; x=1757537254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOX3t1tNI835fQlZszqsBPrAw0emLRXFXBi/KdgVw70=;
        b=VEU5Y9vp8mJEoAQpqQzvhFg7KHum4ukjQbWCIc4rNdnWOrenNTO3QW/DKe/NgTDjYb
         bTlpIoSzdsS+kVqDES/HzO/mGc9oA8u3L7icSwzJduP43KhHXarESZ9PpqkL0BuFV3ay
         DqZlwUKFOt2OUqJSgLCuaZPOdfBvT3KPjEy9WwqixjNaKEB48UDnZ8n1Oh8mxMQZDqW7
         akwiPNxT4Hzv4IxnrMyH3oBv8lxXezqVtIbUJHTLa+DOAI1msW0NeYckRr58LWnOidiW
         0pd+ftpZrkxc+efHtozdXgOAcPf+MkccuuTR2X22OVtzPp53X2CN+Xc6sj5dYGETxUAi
         bHag==
X-Gm-Message-State: AOJu0YzK8zytwOQcoGLAWOCaZxLHsAPg1CaJeKqAuaklLLXLRsfGDZ/x
	DzLKmzucZwTPMPtR3e1J+gukTsXeiLUVBLlz+SuRBubpwVZcvWR2V7rT97j1SbkTvL779QlHnRu
	FvW8XWk/pmBMTKCPmHUpxXhicTDQOZxSaeJaVPf5NyUb4VLBG07Q=
X-Gm-Gg: ASbGncsgqJ1LtHbOwjZAJHXq0HYVHyN0qKJqZVBjpXQseTbxIYG0wJEmFriIPBrl40R
	OfkPGAi81CobCcqJ88VCjjAYj5uM7nuAH6F34Qluc67qzev9bLfxTNUsIbBwyG8Q4Hejqi0hEx6
	oFyqynMiSPLiOo7i3l1aJBVtp0dTEMs2TnSa2wHTCkYyElBIEhdRNXZ/1RoMjAUx8wpxNc9i2OG
	ZR4898=
X-Google-Smtp-Source: AGHT+IGkMQJVBqRXSGU922Gw2SQoYESmtMZntOQt802KtRgput2nM13fgy1GouC7w5vlqACo5BZPxtKEyiF/nxMIIPM=
X-Received: by 2002:a17:90b:48cb:b0:323:28ac:4594 with SMTP id
 98e67ed59e1d1-32815414089mr18348545a91.5.1756932454352; Wed, 03 Sep 2025
 13:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902110049.4437-1-disclosure@aisle.com> <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
 <CAHC9VhRtXzSGafaqLm_EDq=rj4BhDaOkaS0uJ89W-Scw2Zyxuw@mail.gmail.com>
 <CAHC9VhS7PyKsGnoT17WojZmUEqYh-HgP2TS-DQdct0yv2BfZqg@mail.gmail.com> <8e395d8a-2875-4f78-9118-facd5de09a30n@aisle.com>
In-Reply-To: <8e395d8a-2875-4f78-9118-facd5de09a30n@aisle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:47:22 -0400
X-Gm-Features: Ac12FXzsE6wqWc2GfQx0HjiRC03KXQ2G9UrGjNyJ4MGKThk3ZmUlEY1kfxw0aqE
Message-ID: <CAHC9VhShXiHnyN-Q0tWJ9o8advmJ_FKXCCOHb1sKF_noz-JW5Q@mail.gmail.com>
Subject: Re: [PATCH] audit: fix out-of-bounds read in audit_compare_dname_path
To: Disclosure <disclosure@aisle.com>
Cc: "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>, "eparis@redhat.com" <eparis@redhat.com>, 
	"security@kernel.org" <security@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stanislav Fort <stanislav.fort@aisle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:03=E2=80=AFPM Disclosure <disclosure@aisle.com> wr=
ote:
>
> Hi Paul,
>
> Yes, please go ahead and change the Signed-off-by to:
> Signed-off-by: Stanislav Fort <stanislav.fort@aisle.com>
>
> Sorry for the slight delay and thanks for the quick review, testing, and =
for adding the Fixes tag.

No worries, thanks for the fix :)

I'm merging this into audit/stable-6.17 and I'll plan to send this up
to Linus later this week.

--=20
paul-moore.com
