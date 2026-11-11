Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408666;
	b=l4Bvy06s2jVm0csTfGxdj4JGbmIOech7jSH72nLJ2Wra9El8JsxnoYPCmzV1iOvxOr7c
	 Rgp2idIcEfU0Fg1PYMPh04D/JEaBnW8ikHtdLGEqwqokf3lkDUwogvRJROwSOgYpPGFxb
	 0q+Rh5cC14K8QOxfyrlAFEWetm0R+VLwEXAhknlkGH0sWkDbRZI8uOvFL6/Fkyrl4InVi
	 MP0+4nw4XwdATKWgZxgpysHyOb+kmZv3yYbyzAqp0geHGv5p41i6nA/HGGbEV7qSEUbhn
	 y9jxH7ZgT8JDA71ofstIJLW0gBpMYMdMTvrdSOWyW1DoFdT388PPLBZEjcUVO7cppJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408666;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=2hu5TpdMLVTdAA0q6U3O2c6TIRIRZWKhs36CHsulp2Y=;
	b=E2r9S6lolDJzMdgdR91XbrcA+rMVtGG/OhyQuOQIxwfepW4sZ92liiIF71siSQNDdw9W
	 yucrQUXJLCb/PxmVXm9ZKArLfnORIggtgIPZw9pHs89fSwP5ZD4R1yXNtDPG3wDxDAyYi
	 PSNmxe9foIwLkK8W5d7qSNujaCXEiFm4Wr7zRRW9Hh6/JDGyI/j1tAGDXsmo4RJI6YwkO
	 eYlz6iY/cVN2RA3kMh2eroplYr2AZvNaSuBzf90Bn6/7GMqgsjL/xJktfnje9La3pmd61
	 xftVvUcFAkcuOyVtNC0e0f/+Bd7fDxJOYxW8xk6YoFO3KtWMnp3vmYQwZi1TvxMiurA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BC2Dcr5Q;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739E606A335
	for <audit@vger.kernel.org>; Wed, 11 Nov 2026 14:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2739E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BC2Dcr5Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794408665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hu5TpdMLVTdAA0q6U3O2c6TIRIRZWKhs36CHsulp2Y=;
	b=BC2Dcr5QyOqxq23D7UYuu5VW80pFmCNCZAP0ZgODlc2l0SZYaMjdBcv5uY6cwbFNXSBosT
	G/SSV0ljHR580KSzRs8yPsAfN5LboNIaswM6pyRITgH2sY8vZQe7VK1p4IvZNFAoeXHzx+
	RWt712hXuOSdSFN5koa025wc7/mb/QE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346--Oyqlz83NhGTykeA6gG3cg-1; Wed, 11 Nov 2026 09:51:03 -0500
X-MC-Unique: -Oyqlz83NhGTykeA6gG3cg-1
X-Mimecast-MFC-AGG-ID: -Oyqlz83NhGTykeA6gG3cg_1794408662
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c4d1684d1b3so296372166b.1
        for <audit@vger.kernel.org>; Wed, 11 Nov 2026 06:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408662; x=1795013462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2hu5TpdMLVTdAA0q6U3O2c6TIRIRZWKhs36CHsulp2Y=;
        b=Nx7pt6Z4kTk0aNSyv3JiANeVTlgp3rzasc/4Z39K65I1LCMKCmbjJBkz1wEH25Pgu7
         oOUQL/l1apZAdmg9wN1mqPN55d2O+pXogi5YRZpw6HxHa2lldVaIKdqJDGRuElzsz/9p
         U+883SimK/WKEzh1maxX1iXtnWTX7/HvhYvdfwrkoRHDx8OdBhFfgd3xgO0QMNBIbCnp
         zrYPt4gHgge5tMwr7mVPGWmMjRoBefpq/a+ll4VWYJvURkWr56UeyyxZYagRX7F0ugf0
         Ae/YLheiPuytwNowT+RtP07G3s6grziNZEwM8Z7DqCZsWikMlGOLqu5U1HT1Tr3tMvXr
         9xhg==
X-Forwarded-Encrypted: i=1; AL+hErEDAJR83ic2MMws5L9oSPeFT3nZ3JyeBu/WWrLLtkgdt8umGQc66h1957dn+dlCxKaMsjSV2w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8TvGa412VSZgRYK8RUpRNb6DA7Xo0GKsD51Gjk+dZDHi5BgQ1T
	gHfRxUJ/F5neGgU/DLGLEYLCy2i2z/x8hx33SucK9+zEeSybG+trBODol2aO6RRUC591/L1+n2o
	HokW/Lcn3fgtvyATBPhGG7rYtTnOIjJt8oakzBSOWAWrh19MH2h/6SE/Br/y03Ia7zgiagTUbSy
	7SU+2/VgGgPeTxBEN1oAiCuWDIZ8JHF+Q=
X-Gm-Gg: AYBFou1mQD/PlYGc+JUQctCDlJns2m8s8fnCSd8uvPUThZYtYkEgAiOWjA489ZiVgvB
	a0wrgFDSN9Ow5pvFK1QObqBMek5KJUivmFZRJCPYP7ODtDVTNxdAyiNEQRbVa696wUZlSa/WtQy
	gMs0rYldP6XMFqpiincATNH8gjqU5S7omBD3QFvh23T9Mw70BMaZCX5kCg+AlSOFTqEJifwTkDo
	Az+j+uBWmc+zfYJWVKQusvKRU7tAxUwvtTZtIxHsLqqWA==
X-Received: by 2002:a17:907:3e1e:b0:c50:475d:980e with SMTP id a640c23a62f3a-c5066ca9f9emr181823966b.38.1794408662041;
        Wed, 11 Nov 2026 06:51:02 -0800 (PST)
X-Received: by 2002:a17:907:3e1e:b0:c50:475d:980e with SMTP id
 a640c23a62f3a-c5066ca9f9emr181822066b.38.1794408661612; Wed, 11 Nov 2026
 06:51:01 -0800 (PST)
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111110200.30415-1-jeff@bencteux.fr> <e817126f-83b7-4450-a893-ac4e59460ae1@app.fastmail.com>
 <avRzKRB2f_dP-xEv@ultrabook.localdomain> <6f26e8fd-6198-4c2c-9702-3b7b8dc73f7c@app.fastmail.com>
In-Reply-To: <6f26e8fd-6198-4c2c-9702-3b7b8dc73f7c@app.fastmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 11 Nov 2026 11:50:48 -0300
X-Gm-Features: AclHuK9bWqPtxsq5yiZl7_GWpS_B8DMo81VBx_AeLSjplhjtXPuSUA6-AMhuzyg
Message-ID: <CAABTaaCAhp7n-yNLMPoyJ6=uYaLjkA82KT0CTG4MGfKHdjMvDQ@mail.gmail.com>
Subject: Re: [PATCH] audit: add missing syscalls to signal class
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeffrey Bencteux <jeff@bencteux.fr>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: feZzs_rnbuJdaxOaRGun50FgjhgWiYoA62Qb8syEJ_Q_1794408662
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:31=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Wed, Nov 11, 2026, at 14:52, Jeffrey Bencteux wrote:
> > On Wed, Nov 11, 2026 at 12:18:01PM +0100, Arnd Bergmann wrote:
> >> Why the #ifdef checks? These should be available on all architectures.
> >
> > I included them as convention, should they be removed?
>
> Not sure where the convention comes from, it just seemed
> odd that you have the #ifdef checks for the newly added
> entries but not the ones that are already in this file.
>
> I had not checked the other files that have similar ones.
>
>      Arnd
>

Hello everyone!

It's not a convention. Arnd is right, ifdef checks should only be used
for the ones that are not available on all architectures.

Jeffrey, please take a look in this commit c0d73c09381e ("audit: add
missing syscalls to PERM class tables"). Note that '__NR_statx' is not
guarded by a ifdef.

I hope it helps.

-Ricardo

